import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/view/assigned_trademan_screen/assigned_trademan_view.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:fliproadmin/ui/widget/trade_man_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssignedPartners extends StatelessWidget {
  const AssignedPartners({Key? key}) : super(key: key);
  static const routeName = '/AssignedPartners';

  @override
  Widget build(BuildContext context) {
    final loadedTradman = ModalRoute.of(context)!.settings.arguments as appUsers;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
          bannerText: "Assigned Partners",
          showBothIcon: false,
          automaticallyImplyLeading: true,
        ),
      ),
      body: Consumer<LoadedProjectProvider>(builder: (ctx, loadedProjectProvider, c) {
        if (loadedProjectProvider.getLoadedProject == null &&
            loadedProjectProvider.getLoadedProject?.franchisee == null &&
            loadedTradman == appUsers.franchise) {
          return const Center(child: Text("No franchise assigned"));
        }
        return ListView.builder(
            itemCount: loadedProjectProvider.getLoadedProject?.franchisee?.length,
            itemBuilder: (_, index) {
              UserRoleModel userRoleModel = loadedProjectProvider.getLoadedProject!.franchisee![index];
              return InkWell(
                  onTap: () {
                    HelperWidget.handleTrademanNavigation(
                        user: loadedTradman,
                        context: context,
                        currentRoute: routeName/*AssignedTrademan.routeName*/,
                        userRoleModel: userRoleModel);
                  },
                  child: TrademanListItem(userRoleModel: userRoleModel));
            });
      }),
    );
  }
}