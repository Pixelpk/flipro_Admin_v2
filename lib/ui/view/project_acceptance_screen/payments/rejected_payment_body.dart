import 'package:fliproadmin/ui/view/project_overview_screen/project_overview_Screen.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_screen.dart';
import 'package:fliproadmin/ui/widget/approve_list_item.dart';
import 'package:fliproadmin/ui/widget/view_project_details.dart';
import 'package:flutter/material.dart';

class RejectedPaymentBody extends StatelessWidget {
  const RejectedPaymentBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return  ApproveListItem(viewProjectCallback: (){
          ///ARGS = PROJECT REJECTED?
          Navigator.pushNamed(context, ViewProjectScreen.routeName,arguments: false);
        },
          rejected: true,

        );
      },
      itemCount: 20,
    );
  }
}
