
import 'package:fliproadmin/ui/view/activity_screen/activity_list_item.dart';
import 'package:fliproadmin/ui/view/view_project_screen/view_project_screen.dart';
import 'package:flutter/material.dart';

class CompletedProjectScreen extends StatelessWidget {
  const CompletedProjectScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (c, i) {
          return  InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(ViewProjectScreen.routeName);
              },
              child: const ActivityListItem(
                timeStampLabel: "Completed",
              ));
        });
  }
}
