// import 'package:fliproadmin/ui/view/activity_screen/activity_list_item.dart';
// import 'package:fliproadmin/ui/view/project_overview_screen/project_overview_Screen.dart';
// import 'package:flutter/material.dart';
//
// class NewProjectScreen extends StatelessWidget {
//   const NewProjectScreen({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: 10,
//         itemBuilder: (c, i) {
//           return InkWell(
//               onTap: () {
//                 Navigator.of(context).pushNamed(ProjectOverviewScreen.routeName,
//                     arguments: true);
//               },
//               child: const ActivityListItem(
//                 timeStampLabel: '',
//               ));
//         });
//   }
// }
import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/services/projects_service/projects_service.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/activity_screen/activity_list_item.dart';
import 'package:fliproadmin/ui/view/project_overview_screen/project_overview_Screen.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class ClosedProjectScreen extends StatefulWidget {
  const ClosedProjectScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ClosedProjectScreen> createState() => _ClosedProjectScreenState();
}

class _ClosedProjectScreenState extends State<ClosedProjectScreen> {
  static const _pageSize = 20;

  final PagingController<int, ProjectProvider> _pagingController =
  PagingController(firstPageKey: 1);

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

  Future<void> _fetchPage(int pageKey) async {
    try {
      GenericModel genericModel = await ProjectService().getAllActivityProjects(
          accessToken:
          Provider.of<UserProvider>(context, listen: false).getAuthToken,
          page: pageKey,
          status: "completed"
      );
      if (genericModel.statusCode == 200) {
        ProjectResponse projectResponse = genericModel.returnedModel;
        if (projectResponse != null && projectResponse.projectsList != null) {
          final newItems = projectResponse.projectsList ?? [];
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
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () => Future.sync(
              () => _pagingController.refresh(),
        ),
        child: PagedListView<int, ProjectProvider>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<ProjectProvider>(
              itemBuilder: (context, project, index) => ActivityListItem(
                project: project,
                timeStampLabel: '',
              )

          ),
        ));

  }
}
