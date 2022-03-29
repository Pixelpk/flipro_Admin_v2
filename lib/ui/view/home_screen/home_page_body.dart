import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/core/view_model/projects_provider/projects_provider.dart';
import 'package:fliproadmin/ui/view/add_project_screen/add_project_screen.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'home_item.dart';
import 'home_screen.dart';

class HomePageBody extends StatefulWidget {
  HomePageBody({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  void initState() {
    Future.microtask(() => Provider.of<ProjectsProvider>(context, listen: false)
        .fetchProjects(initialLoading: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.addchart_outlined),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const AddProjectScreen(
                    isNewProject: true,
                  )));
        },
      ),
      body: Consumer<ProjectsProvider>(builder: (ctx, projectProvider, c) {
        print(projectProvider.getLoadingState);
        if (projectProvider.getLoadingState == loadingState.loading &&
            projectProvider.getCurrentPage == 1) {
          return HelperWidget.progressIndicator();
        }
        return LazyLoadScrollView(
            isLoading: projectProvider.getLoadingState == loadingState.loading,
            onEndOfPage: () =>
                Provider.of<ProjectsProvider>(context, listen: false)
                    .fetchProjects(initialLoading: false),
            child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  // mainAxisExtent: 52.w,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 10,
                ),
                itemCount: projectProvider.getProjects.length,
                itemBuilder: (BuildContext ctx, index) {
                  var project = projectProvider.getProjects[index];
                  return ChangeNotifierProvider<ProjectProvider>.value(
                    value: project,
                    child: const HomeItem(),
                  );
                }));
      }),
    );
  }
}
