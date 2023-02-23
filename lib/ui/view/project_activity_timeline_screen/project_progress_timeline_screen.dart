import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/services/progress_service/progress_service.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../../core/model/project_activity/project_activity_response.dart';

class ProjectActivityTimeLineScreen extends StatefulWidget {
  const ProjectActivityTimeLineScreen({Key? key}) : super(key: key);
  static const routeName = '/ProjectActivityTimeLineScreen';

  @override
  State<ProjectActivityTimeLineScreen> createState() => _ProjectActivityTimeLineScreenState();
}

class _ProjectActivityTimeLineScreenState extends State<ProjectActivityTimeLineScreen> {
  final _pageSize = 20;
  final PagingController<int, ProjectActivityModel> _pagingController = PagingController(firstPageKey: 1);

  Future<void> _fetchPage(int pageKey) async {
    try {
      GenericModel genericModel = await ProgressService.getProjectActivity(
          accessToken: Provider.of<UserProvider>(context, listen: false).getAuthToken,
          page: pageKey,
          projectId: Provider.of<LoadedProjectProvider>(context, listen: false).getLoadedProject!.id!);
      if (genericModel.statusCode == 200) {
        ActivityTimeLineResponse activityResponse = genericModel.returnedModel;
        if (activityResponse != null && activityResponse.data != null && activityResponse.data!.activities != null) {
          final newItems = activityResponse.data!.activities ?? [];
          final isLastPage = newItems.length < _pageSize;
          if (isLastPage) {
            _pagingController.appendLastPage(newItems);
          } else {
            final nextPageKey = pageKey + 1;
            _pagingController.appendPage(newItems, nextPageKey);
          }
        }
      } else if (genericModel.statusCode == 400 || genericModel.statusCode == 422 || genericModel.statusCode == 401) {
        GetXDialog.showDialog(title: genericModel.title, message: genericModel.message);
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
              automaticallyImplyLeading: true, bannerText: "Activity Timeline", showBothIcon: false)),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => _pagingController.refresh(),
        ),
        child: PagedListView<int, ProjectActivityModel>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<ProjectActivityModel>(
              itemBuilder: (context, activity, index) => TimelineTile(
                    alignment: TimelineAlign.manual,
                    lineXY: 0.08,
                    isFirst: index == 0,
                    isLast: index == _pagingController.itemList!.length - 1,
                    indicatorStyle: IndicatorStyle(
                      width: 30,
                      height: 30,
                      indicator: _IndicatorExample(number: '${index + 1}'),
                      drawGap: false,
                    ),
                    beforeLineStyle: const LineStyle(thickness: 3, color: AppColors.mainThemeBlue),
                    endChild: GestureDetector(
                      child: _RowExample(
                        activityModel: activity,
                      ),
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SingleProgressScreen(progressModel: progress,)));
                      },
                    ),
                  )),
        ),
      ),
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
        style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),
      ),
    );
  }
}

class _RowExample extends StatelessWidget {
  const _RowExample({Key? key, required this.activityModel}) : super(key: key);

  final ProjectActivityModel activityModel;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 10, bottom: 10, top: 10),
        decoration: BoxDecoration(color: AppColors.mainThemeBlue, borderRadius: BorderRadius.circular(15)),
        child: Row(children: <Widget>[
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                Text("${activityModel.dateTime}",
                    style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white)),
                Row(children: [
                  Flexible(
                      child: Text("${activityModel.description}",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.white, fontSize: 14),
                          overflow: TextOverflow.clip))
                ])
              ]))
        ]));
  }
}

class Example1Vertical extends StatelessWidget {
  const Example1Vertical({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate(<Widget>[Container(color: Colors.white, child: TimelineTile())]));
  }
}

class Example1Horizontal extends StatelessWidget {
  const Example1Horizontal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate(<Widget>[
      Row(children: [
        Container(
            constraints: const BoxConstraints(maxHeight: 80),
            color: Colors.white,
            child: TimelineTile(axis: TimelineAxis.horizontal, alignment: TimelineAlign.center))
      ])
    ]));
  }
}
