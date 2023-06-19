import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/model/users_model/users_model.dart';
import 'package:fliproadmin/core/services/users_service/user_service.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/projects_provider/projects_provider.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/members_screen/add_member/add_member_screen.dart';
import 'package:fliproadmin/ui/view/view_trademan_profile/view_trademan_profile.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:fliproadmin/ui/widget/search_user.dart';
import 'package:fliproadmin/ui/widget/trade_man_list_item.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class AddPartnersScreen extends StatefulWidget {
  const AddPartnersScreen({Key? key}) : super(key: key);
  static const routeName = '/addPartnersScreen';

  @override
  State<AddPartnersScreen> createState() => _AddPartnersScreenState();
}

class _AddPartnersScreenState extends State<AddPartnersScreen> {

  //
  // static const _pageSize = 20;
  // final PagingController<int, UserRoleModel> _pagingController = PagingController(firstPageKey: 0);
  //
  // Future<void> _fetchPage(int pageKey) async {
  //   try {
  //     GenericModel genericModel = await UsersService.getUsers(
  //         page: pageKey,
  //         type: 'franchise',
  //         token:
  //         Provider.of<UserProvider>(context, listen: false).getAuthToken);
  //     if (genericModel.statusCode == 200) {
  //       UsersModel usersModel = genericModel.returnedModel;
  //
  //       if (usersModel != null &&
  //           usersModel.data != null &&
  //           usersModel.data!.users != null) {
  //         final newItems = usersModel.data!.users;
  //         final isLastPage = newItems.length < _pageSize;
  //         if (isLastPage) {
  //           _pagingController.appendLastPage(newItems);
  //         } else {
  //           final nextPageKey = pageKey + 1;
  //           _pagingController.appendPage(newItems, nextPageKey);
  //         }
  //       }
  //     }
  //     setState(() {
  //
  //     });
  //   } catch (error) {
  //     print(error);
  //     _pagingController.error = error;
  //   }
  // }

  @override
  void initState() {
    // _pagingController.addPageRequestListener((pageKey) {
    //   _fetchPage(pageKey);
    // });
    Future.microtask(
      () {
        final args = ModalRoute.of(context)!.settings.arguments as Map;
        final appUser = args['appUser'];
        final projectId = args['projectId'];
        final userRole = LogicHelper.userTypeFromEnum(appUser);
        Provider.of<ProjectsProvider>(context, listen: false).fetchUsers(
            initialLoading: true, userRole: userRole, projectId: projectId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final appUser = args['appUser'];
    final userTitle = LogicHelper.userTitleHandler(appUser);
    final userRole = LogicHelper.userTypeFromEnum(appUser);
    final projectId = args['projectId'];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ///CREATE MEMBER ON RUNTIME AND ASSIGN IT TO USER
          ///true for assigning as well
          ///false for just to create
          Navigator.of(context)
              .pushNamed(AddMemberScreen.routeName, arguments: {
            "appUsers": appUser,
            "createAssign": true,
          });
        },
        child: const Icon(
          Icons.person_add_alt_1,
        ),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: CustomAppBar(
          automaticallyImplyLeading: true,
          bannerText: "Add $userTitle",
          showBothIcon: false,
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          Consumer<ProjectsProvider>(builder: (ctx, projectProvider, c) {
            print(projectProvider.getLoadingState);
            if (projectProvider.getLoadingState == LoadingState.loading &&
                projectProvider.getCurrentPage == 1) {
              return HelperWidget.progressIndicator();
            }
            return /*PagedListView<int, UserRoleModel>(
              pagingController: _pagingController,
              padding: EdgeInsets.only(top: 9.h),
              builderDelegate: PagedChildBuilderDelegate<UserRoleModel>(
                  itemBuilder: (context, user, index) => InkWell(
                    onTap: () {
                      // Navigator.pushNamed(context, ViewTradeManProfile.routeName,
                      //     arguments: user);
                      HelperWidget.handleTrademanNavigation(
                          context: context,
                          user: appUser,
                          userRoleModel: user,
                          currentRoute: args['currentRoute']);
                    },
                    child:  TrademanListItem(
                      userRoleModel: user,
                      showAssignButton: true,
                    ),
                  )
              ),
            );*/
            LazyLoadScrollView(
                isLoading:
                    projectProvider.getLoadingState == LoadingState.loading,
                onEndOfPage: () =>
                    Provider.of<ProjectsProvider>(context, listen: false)
                        .fetchUsers(
                            initialLoading: false,
                            projectId: projectId,
                            userRole: userRole),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 9.h),
                  itemBuilder: (context, index) {
                    UserRoleModel fetchedUser =
                        projectProvider.getFetchedUsers[index];
                    return InkWell(
                        onTap: () {
                          HelperWidget.handleTrademanNavigation(
                              context: context,
                              user: appUser,
                              userRoleModel: fetchedUser,
                              currentRoute: args['currentRoute']);
                        },
                        child: TrademanListItem(
                          userRoleModel: fetchedUser,
                          showAssignButton: true,
                        ));
                  },
                  itemCount: projectProvider.getFetchedUsers.length,
                ));
          }),
          Container(
              padding:
                  EdgeInsets.only(right: 3.w, left: 3.w, bottom: 1.h, top: 1.h),
              height: 5.5.h,
              child: SearchUsers(
                appuser: appUser,
                currentRoute: args['currentRoute'],
                projectId: projectId,
                isPortrait: true,
                role: userTitle.toLowerCase(),
              )),
        ],
      ),
    );
  }
}
