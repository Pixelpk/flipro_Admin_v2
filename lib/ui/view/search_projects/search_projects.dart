
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utilities/app_colors.dart';
import '../../../core/view_model/project_provider/project_provider.dart';
import '../../../core/view_model/projects_provider/projects_provider.dart';
import '../../../core/view_model/search_project_provider/search_project_provider.dart';
import '../../../core/view_model/user_provider/user_provider.dart';
import '../../widget/helper_widget.dart';
import '../activity_screen/activity_list_item.dart';

class SearchProjectsScreen extends StatefulWidget {
  static const routeName = '/SearchProjectProvider';

  const SearchProjectsScreen({
    Key? key,
  }) : super(key: key);
  @override
  State<SearchProjectsScreen> createState() => _SearchProjectsScreenState();
}

class _SearchProjectsScreenState extends State<SearchProjectsScreen> {

  @override
  void initState() {
    Provider.of<SearchProjectProvider>(context, listen: false).clear();
    super.initState();
  }

  @override
  void dispose() {
     controller.dispose();
    super.dispose();
  }
  FloatingSearchBarController controller = FloatingSearchBarController();
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 100.h,
      child: FloatingSearchBar(
            hint: "Search Project",
            controller: controller,
            automaticallyImplyBackButton: false,
            automaticallyImplyDrawerHamburger: false,
            scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
            transitionDuration: const Duration(milliseconds: 800),
            transitionCurve: Curves.easeInOut,
            iconColor: AppColors.mainThemeBlue,
            physics: const BouncingScrollPhysics(),
            axisAlignment: 0.0,
            openAxisAlignment: 0.0,
            borderRadius: BorderRadius.circular(10),
            width: 100.w,
            leadingActions: [
              IconButton(onPressed: (){
                controller.close();
                Provider.of<SearchProjectProvider>(context, listen: false).clear();
              }, icon: const Icon(Icons.arrow_back))
            ],
            backdropColor: AppColors.blueScaffoldBackground,
            openWidth: 100.w,
            isScrollControlled: true,
            debounceDelay: const Duration(milliseconds: 800),
            onQueryChanged: (query) {
              Provider.of<SearchProjectProvider>(context, listen: false).searchProjects(
                authToken: context.read<UserProvider>().getAuthToken,
                searchQuery: query,
              );
            },
            transition: CircularFloatingSearchBarTransition(),
            actions: [
              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,

              ),
            ],
            builder: (context, transition) {
              return Consumer<SearchProjectProvider>(builder: (ctx, projectProvider, c) {
                print(projectProvider.getLoadingState);
                if (projectProvider.getLoadingState == loadingState.loading) {
                  return HelperWidget.progressIndicator();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ProjectProvider project = projectProvider.getSearchedProjects[index];
                    return ActivityListItem(
                      project: project,
                      timeStampLabel: '',
                    );
                  },
                  itemCount: projectProvider.getSearchedProjects.length,
                );
              });
            },
          ),
    );
  }
}
