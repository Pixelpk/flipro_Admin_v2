import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:fliproadmin/ui/widget/trade_man_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssignedTrademan extends StatelessWidget {
  const AssignedTrademan({Key? key}) : super(key: key);
  static const routeName = '/AssignedTrademan';

  @override
  Widget build(BuildContext context) {
    final loadedTradman =
        ModalRoute.of(context)!.settings.arguments as appUsers;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
          bannerText: "Assigned Trade-Man",
          showBothIcon: false,
          automaticallyImplyLeading: true,
        ),
      ),
      body: Consumer<LoadedProjectProvider>(
          builder: (ctx, loadedProjectProvider, c) {
        if (loadedProjectProvider.getLoadedProject == null &&
            loadedProjectProvider.getLoadedProject!.valuers == null &&
            loadedTradman == appUsers.evaluator) {
          return const Center(
            child: Text("No Valuer assigned"),
          );
        }
        if (loadedProjectProvider.getLoadedProject == null &&
            loadedProjectProvider.getLoadedProject!.builder == null &&
            loadedTradman == appUsers.builder) {
          return const Center(
            child: Text("No Valuer assigned"),
          );
        }
        return ListView.builder(
            itemCount: loadedTradman == appUsers.builder
                ? loadedProjectProvider.getLoadedProject!.builder!.length
                : loadedProjectProvider.getLoadedProject!.valuers!.length,
            itemBuilder: (_, index) {
              UserRoleModel userRoleModel = loadedTradman == appUsers.builder
                  ? loadedProjectProvider.getLoadedProject!.builder![index]
                  : loadedProjectProvider.getLoadedProject!.valuers![index];
              return InkWell(
                onTap: () {
                  HelperWidget.handleTrademanNavigation(
                      user: loadedTradman,
                      context: context,
                      currentRoute: AssignedTrademan.routeName,
                      userRoleModel: userRoleModel);
                },
                child: TrademanListItem(
                  userRoleModel: userRoleModel,
                ),
              );
            });
      }),
    );
  }
}
