import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'labeledTextField.dart';

class ProjectInfoSection extends StatelessWidget {
  const ProjectInfoSection({
    Key? key,
    this.readOnly = true,
  }) : super(key: key);
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoadedProjectProvider>(builder: (ctx, project, c) {
      if (project.getLoadingState == loadingState.loading) {
        return SizedBox(height: 70.h, child: HelperWidget.progressIndicator());
      }
      if (project.getLoadedProject == null &&
          project.getLoadingState == loadingState.loaded) {
        return SizedBox(
          height: 70.h,
          child: const Center(
            child: Text("Encounter an Error ,Please try again later"),
          ),
        );
      }
      return SizedBox(
        height: 50.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LabeledTextField(
              label: "Project Title:",
              maxlines: null,
              readonly: readOnly,
              hintText: "${project.getLoadedProject!.title}",
            ),
            LabeledTextField(
              label: "Area:",
              maxlines: null,
              readonly: readOnly,
              hintText: "${project.getLoadedProject!.area}",
            ),
            LabeledTextField(
              label: "Description",
              maxlines: 6,
              readonly: readOnly,
              hintText: "${project.getLoadedProject!.description}",
            ),
          ],
        ),
      );
    });
  }
}
