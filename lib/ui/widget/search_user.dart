
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/projects_provider/projects_provider.dart';
import 'package:fliproadmin/ui/widget/trade_man_list_item.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'helper_widget.dart';

class SearchUsers extends StatefulWidget {
  const SearchUsers(
      {Key? key,
        required this.isPortrait,
        this.projectId,
        required this.currentRoute,
        required this.appuser,
        this.role})
      : super(key: key);
  final String? role;
  final String? currentRoute;
  final int? projectId;
  final bool isPortrait;
  final appUsers appuser;
  @override
  State<SearchUsers> createState() => _SearchUsersState();
}

class _SearchUsersState extends State<SearchUsers> {
  @override
  Widget build(BuildContext context) {
    return FloatingSearchBar(
      hint: "Search ${widget.role}",
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      iconColor: AppColors.mainThemeBlue,
      physics: const BouncingScrollPhysics(),
      axisAlignment: widget.isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      borderRadius: BorderRadius.circular(10),
      width: 90.w,
      backdropColor: AppColors.blueScaffoldBackground,
      openWidth: 100.w,

      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        Provider.of<ProjectsProvider>(context, listen: false).searchUsers(
            userRole: LogicHelper.userTypeFromEnum(widget.appuser),
            initialLoading: true,
            searchQuery: query,
            
            projectId: widget.projectId);
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return Consumer<ProjectsProvider>(builder: (ctx, projectProvider, c) {
          print(projectProvider.getLoadingState);
          if (projectProvider.getLoadingState == loadingState.loading &&
              projectProvider.getCurrentPage == 1) {
            return HelperWidget.progressIndicator();
          }
          return LazyLoadScrollView(

              isLoading:
              projectProvider.getLoadingState == loadingState.loading,
              onEndOfPage: () {
                projectProvider.searchUsers(
                    userRole: LogicHelper.userTypeFromEnum(widget.appuser),
                    initialLoading: false,
                    projectId: widget.projectId);
              },
              child: ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  UserRoleModel fetchedUser =
                  projectProvider.getSearcherUsers[index];
                  return InkWell(
                      onTap: () {
                        HelperWidget.handleTrademanNavigation(
                            context: context,
                            user: widget.appuser,
                            currentRoute: widget.currentRoute,
                            userRoleModel: fetchedUser);
                      },
                      child: TrademanListItem(
                        userRoleModel: fetchedUser,
                      ));
                },
                itemCount: projectProvider.getSearcherUsers.length,
              ));
        });
      },
    );
  }
}
