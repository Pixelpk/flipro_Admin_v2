import 'package:fliproadmin/ui/view/project_overview_screen/project_overview_Screen.dart';
import 'package:fliproadmin/ui/widget/approve_list_item.dart';
import 'package:fliproadmin/ui/widget/view_project_details.dart';
import 'package:flutter/material.dart';

class LatestProjectBody extends StatelessWidget {
  const LatestProjectBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return  ApproveListItem(viewProjectCallback: (){
          ///ARGS = PROJECT REJECTED?
          Navigator.pushNamed(context, ViewProjectDetails.routeName,arguments: false);
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
