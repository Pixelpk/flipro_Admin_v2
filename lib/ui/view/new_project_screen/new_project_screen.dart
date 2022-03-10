
import 'package:fliproadmin/ui/view/activity_screen/activity_list_item.dart';
import 'package:fliproadmin/ui/view/project_overview_screen/project_overview_Screen.dart';
import 'package:flutter/material.dart';

class NewProjectScreen extends StatelessWidget {
  const NewProjectScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (c, i) {
          return InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(ProjectOverviewScreen.routeName,arguments: true);
              },child: const ActivityListItem(timeStampLabel: '',));
        });
  }
}
