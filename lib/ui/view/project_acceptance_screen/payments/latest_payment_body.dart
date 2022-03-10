import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/core/view_model/home_provider/home_provider.dart';
import 'package:fliproadmin/ui/view/project_overview_screen/project_overview_Screen.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_screen.dart';
import 'package:fliproadmin/ui/widget/approve_list_item.dart';
import 'package:fliproadmin/ui/widget/view_project_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LatestPaymentBody extends StatelessWidget {
  const LatestPaymentBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeprovider = Provider.of<HomeProvider>(context);
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return  ApproveListItem(viewProjectCallback: (){
          ///ARGS = PROJECT REJECTED?
          homeprovider.onProjectViewPageChange(1);
          Navigator.pushNamed(context, ViewProjectScreen.routeName,arguments: false);
        },
          rejected: false,
        acceptCallback: (){
          print("ACEPT");
        },
          rejectCallback: (){
            print("rejects");
          },

        );
      },
      itemCount: 20,
    );
  }
}
