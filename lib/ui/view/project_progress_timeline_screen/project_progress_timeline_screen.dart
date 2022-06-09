import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/progress_response/progress_response.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/services/progress_service/progress_service.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/single_progress_screen/single_progress_screen.dart';
import 'package:fliproadmin/ui/widget/colored_label.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ProjectProgressTimeLineScreen extends StatefulWidget {
  const ProjectProgressTimeLineScreen({Key? key}) : super(key: key);
  static const routeName = '/projectProgressTimeLineScreen';

  @override
  State<ProjectProgressTimeLineScreen> createState() =>
      _ProjectProgressTimeLineScreenState();
}

class _ProjectProgressTimeLineScreenState
    extends State<ProjectProgressTimeLineScreen> {
  final _pageSize = 20;
  final PagingController<int, ProgressModel> _pagingController =
      PagingController(firstPageKey: 1);
  Future<void> _fetchPage(int pageKey) async {
    try {
      GenericModel genericModel = await ProgressService.getProjectProgress(
          accessToken:
              Provider.of<UserProvider>(context, listen: false).getAuthToken,
          page: pageKey,
          projectId: Provider.of<LoadedProjectProvider>(context, listen: false)
              .getLoadedProject!
              .id!);
      if (genericModel.statusCode == 200) {
        ProgressResponse progressResponse = genericModel.returnedModel;
        if (progressResponse != null &&
            progressResponse.data != null &&
            progressResponse.data!.progressess != null) {
          final newItems = progressResponse.data!.progressess ?? [];
          final isLastPage = newItems.length < _pageSize;
          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        }
      } else if (genericModel.statusCode == 400 ||
          genericModel.statusCode == 422 ||
          genericModel.statusCode == 401) {
        GetXDialog.showDialog(
            title: genericModel.title, message: genericModel.message);
      }
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
          automaticallyImplyLeading: true,
          bannerText: "Progress Timeline",
          showBothIcon: false,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, ProgressModel>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<ProgressModel>(
              itemBuilder: (context, progress, index) => TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.08,
                    isFirst: index == 0,
                    isLast: index == _pagingController.itemList!.length - 1,
                    indicatorStyle: IndicatorStyle(
                      width: 40,
                      height: 40,
                      indicator: _IndicatorExample(number: '${index + 1}'),
                      drawGap: false,
                    ),
                    beforeLineStyle: const LineStyle(
                        thickness: 3, color: AppColors.mainThemeBlue),
                    endChild: GestureDetector(
                      child: _RowExample(
                        progressModel: progress,
                      ),
                      onTap: () {
                       Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SingleProgressScreen(progressModel: progress,)));
                      },
                    ),
                  )),
        ),
      ),

      // ListView.builder(
      //   itemCount: examples.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     final example = examples[index];
      //
      //     return TimelineTile(
      //       alignment: TimelineAlign.manual,
      //       lineXY: 0.08,
      //       isFirst: index == 0,
      //       isLast: index == examples.length - 1,
      //       indicatorStyle: IndicatorStyle(
      //         width: 40,
      //         height: 40,
      //         indicator: _IndicatorExample(number: '${index + 1}'),
      //         drawGap: false,
      //       ),
      //       beforeLineStyle:
      //           const LineStyle(thickness: 3, color: AppColors.mainThemeBlue),
      //       endChild: GestureDetector(
      //         child: _RowExample(example: example),
      //         onTap: () {
      //           Navigator.of(context).pushNamed(SingleProgressScreen.routeName);
      //         },
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

class _IndicatorExample extends StatelessWidget {
  const _IndicatorExample({Key? key, required this.number}) : super(key: key);

  final String number;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.mainThemeBlue,
      child: Text(
        number,
        style: Theme.of(context)
            .textTheme
            .subtitle1!
            .copyWith(color: Colors.white),
      ),
    );
  }
}

class _RowExample extends StatelessWidget {
  const _RowExample({Key? key, required this.progressModel}) : super(key: key);

  final ProgressModel progressModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 70,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
          color: Colors.amber, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${progressModel.formattedDate}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(color: AppColors.greyDark)),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        "${progressModel.title}",
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: AppColors.mainThemeBlue),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${progressModel.description}",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AppColors.greyDark),
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                )
              ],
            ),
          ),
          const Icon(
            Icons.navigate_next,
            color: AppColors.mainThemeBlue,
            size: 26,
          ),
        ],
      ),
    );
  }
}

class Example1Vertical extends StatelessWidget {
  const Example1Vertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Container(
            color: Colors.white,
            child: TimelineTile(),
          ),
        ],
      ),
    );
  }
}

class Example1Horizontal extends StatelessWidget {
  const Example1Horizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          Row(
            children: [
              Container(
                constraints: const BoxConstraints(maxHeight: 100),
                color: Colors.white,
                child: TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
