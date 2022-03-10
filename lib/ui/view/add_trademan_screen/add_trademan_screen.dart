import 'package:fliproadmin/core/model/users_model/users_model.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/view/access_control_screen/builder_access_control_screen.dart';
import 'package:fliproadmin/ui/view/access_control_screen/valuer_access_control_screen.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/custom_input_decoration.dart';
import 'package:fliproadmin/ui/widget/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../widget/trade_man_list_item.dart';

class AddTradeManScreen extends StatelessWidget {
  const AddTradeManScreen({Key? key}) : super(key: key);
  static const routeName = '/AddTradeManScreen';

  @override
  Widget build(BuildContext context) {
    final appUser = ModalRoute.of(context)!.settings.arguments as appUsers;
    final userTitle = LogicHelper.userTitleHandler(appUser);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: CustomAppBar(
          automaticallyImplyLeading: true,
          bannerText: "Add $userTitle",
          showBothIcon: false,
        ),
      ),
      body: Column(
        children: [
          Container(
            padding:
                EdgeInsets.only(right: 3.w, left: 3.w, bottom: 1.h, top: 2.2.h),
            child: TextFormField(
              decoration: customInputDecoration(
                  context: context,
                  hintText: "Search $userTitle",
                  suffixIcon: const Icon(Icons.search)),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    handleTrademanNavigation(context: context, user: appUser);
                  },
                  child: TrademanListItem(
                    title: userTitle,
                    member: Member(),
                  ));
            },
            itemCount: 10,
          ))
        ],
      ),
    );
  }

  handleTrademanNavigation(
      {required appUsers user, required BuildContext context}) {
    switch (user) {
      // case appUsers.admin:
      //   {
      //     Navigator.of(context).pushNamed(
      //         BuilderAccessControlScreen.routeName) ;
      //   }
      //   break;

      // case appUsers.franchisee:
      //   {
      //     Navigator.of(context).pushNamed(
      //         BuilderAccessControlScreen.routeName) ;
      //   }
      //   break;
      case appUsers.builder:
        {
          Navigator.of(context).pushNamed(BuilderAccessControlScreen.routeName);
        }
        break;
      case appUsers.evaluator:
        {
          Navigator.of(context).pushNamed(ValuerAccessControlScreen.routeName);
        }
        break;
      default:
        {}
        break;
    }
  }
}
