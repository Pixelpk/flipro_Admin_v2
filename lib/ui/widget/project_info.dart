import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'labeledTextField.dart';

class ProjectInfoSection extends StatelessWidget {
  const ProjectInfoSection({
    Key? key,
    this.readOnly = false,
  }) : super(key: key);
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoadedProjectProvider>(builder: (ctx, project, c) {
      if (project.getLoadingState == loadingState.loading) {
        return SizedBox(height: 70.h, child: HelperWidget.progressIndicator());
      }
      if (project.getLoadedProject == null && project.getLoadingState == loadingState.loaded) {
        return SizedBox(
          height: 70.h,
          child: const Center(
            child: Text("Encounter an Error ,Please try again later"),
          ),
        );
      }
      return SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Project Address:",
              maxlines: null,
              readonly: true,
              hintText: "${project.getLoadedProject!.projectAddress}",
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              inputFormatter: ThousandsFormatter(),
              label: "Area:",
              maxlines: null,
              readonly: true,

              hintText: "${project.getLoadedProject!.area}",
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Project title:",
              maxlines: 1,
              readonly: true,
              hintText: "${project.getLoadedProject!.title}",
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Description:",
              maxlines: 6,
              readonly: true,
              hintText: "${project.getLoadedProject!.description}",
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Applicant Name:",
              maxlines: 1,
              readonly: true,
              hintText: project.getLoadedProject!.applicantName,
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              inputFormatter: ThousandsFormatter(),
              label: "Anticipated Budget:",
              maxlines: 1,
              readonly: true,
              hintText: "${project.getLoadedProject!.anticipatedBudget}",
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Applicant Address:",
              maxlines: 1,
              readonly: true,
              hintText: "${project.getLoadedProject!.applicantAddress}",
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Applicant Phone:",
              maxlines: 1,
              readonly: true,
              hintText: '${project.getLoadedProject!.phone}',
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              inputFormatter: ThousandsFormatter(),
              label: "Property Debt:",
              maxlines: 1,
              readonly: true,
              hintText: '${project.getLoadedProject!.propertyDebt}',
            ),
            SizedBox(
              height: 1.h,
            ),
          ],
        ),
      );
    });
  }
}
