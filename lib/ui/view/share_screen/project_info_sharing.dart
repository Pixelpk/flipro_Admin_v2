import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/share_provider/share_provider.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProjectInFoShare extends StatefulWidget {
  const ProjectInFoShare({
    Key? key,
    this.readOnly = true,
  }) : super(key: key);
  final bool readOnly;

  @override
  State<ProjectInFoShare> createState() => _ProjectInFoShareState();
}

class _ProjectInFoShareState extends State<ProjectInFoShare> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LoadedProjectProvider, ShareProvider>(
        builder: (ctx, project, shareProvider, c) {
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
            height: 100.h,
            width: 100.w,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      "Select Project Info",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  LabeledTextField(
                    onTab: () {
                      shareProvider
                          .updateTitleStatus(project.getLoadedProject!.title!);
                    },
                    label: "Project Title:",
                    maxlines: null,
                    readonly: widget.readOnly,
                    fillColor: shareProvider.projectInfo.title!
                        ? AppColors.mainThemeBlue
                        : null,
                    hintText: "${project.getLoadedProject!.title}",
                  ),
                  LabeledTextField(
                    onTab: () {
                      shareProvider
                          .updateAreaStatus(project.getLoadedProject!.area!);
                    },
                    fillColor: shareProvider.projectInfo.areaSelectecd!
                        ? AppColors.mainThemeBlue
                        : null,
                    label: "Area:",
                    maxlines: null,
                    readonly: widget.readOnly,
                    hintText: "${project.getLoadedProject!.area}",
                  ),
                  LabeledTextField(
                    onTab: () {
                      shareProvider
                          .updateEmailStatus(project.getLoadedProject!.email!);
                    },
                    fillColor: shareProvider.projectInfo.email!
                        ? AppColors.mainThemeBlue
                        : null,
                    label: "Applicant Email:",
                    maxlines: null,
                    readonly: widget.readOnly,
                    hintText: "${project.getLoadedProject!.email}",
                  ),
                  LabeledTextField(
                    onTab: () {
                      shareProvider.updateDebtStatus(
                          project.getLoadedProject!.propertyDebt.toString());
                    },
                    fillColor: shareProvider.projectInfo.debt!
                        ? AppColors.mainThemeBlue
                        : null,
                    label: "Property debt",
                    maxlines: null,
                    readonly: widget.readOnly,
                    hintText: "${project.getLoadedProject!.propertyDebt}",
                  ),
                  LabeledTextField(
                    onTab: () {
                      shareProvider.updateBudgetStatus(
                          project.getLoadedProject!.anticipatedBudget.toString());
                    },
                    fillColor: shareProvider.projectInfo.anticipatedBudget!
                        ? AppColors.mainThemeBlue
                        : null,
                    label: "Anticipated Budget",
                    maxlines: null,
                    readonly: widget.readOnly,
                    hintText: "${project.getLoadedProject!.anticipatedBudget}",
                  ),
                  LabeledTextField(
                    onTab: () {
                      shareProvider.updateDescriptionStatus(
                          project.getLoadedProject!.description!);
                    },
                    fillColor: shareProvider.projectInfo.descripton!
                        ? AppColors.mainThemeBlue
                        : null,
                    label: "Description",
                    maxlines: 6,
                    readonly: widget.readOnly,
                    hintText: "${project.getLoadedProject!.description}",
                  ),
                  LabeledTextField(
                    onTab: () {
                      shareProvider.updateValueStatus(project
                          .getLoadedProject!.currentPropertyValue
                          .toString());
                    },
                    fillColor: shareProvider.projectInfo.currentValue!
                        ? AppColors.mainThemeBlue
                        : null,
                    label: "Current Value",
                    maxlines: null,
                    readonly: widget.readOnly,
                    hintText: "${project.getLoadedProject!.currentPropertyValue}",
                  ),
                ],
              ),
            ),
          );
        });
  }
}
