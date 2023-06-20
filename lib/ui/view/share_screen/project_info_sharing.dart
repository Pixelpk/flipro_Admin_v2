import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/share_provider/share_provider.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
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
  var formatter = NumberFormat('#,##0.' + "#" * 5);

  @override
  Widget build(BuildContext context) {
    return Consumer2<LoadedProjectProvider, ShareProvider>(builder: (ctx, project, shareProvider, c) {
      if (project.getLoadingState == LoadingState.loading) {
        return SizedBox(height: 70.h, child: HelperWidget.progressIndicator());
      }
      if (project.getLoadedProject == null && project.getLoadingState == LoadingState.loaded) {
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
                  shareProvider.updateProjectAddressStatus(project.getLoadedProject!.projectAddress!);
                },
                label: "Project Address:",
                maxLines: null,
                readonly: widget.readOnly,
                fillColor: shareProvider.projectInfo.projectAddress! ? AppColors.mainThemeBlue : null,
                hintText: "${project.getLoadedProject!.projectAddress}",
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateAreaStatus(project.getLoadedProject!.area!);
                },
                fillColor: shareProvider.projectInfo.areaSelectecd! ? AppColors.mainThemeBlue : null,
                label: "Area:",
                maxLines: null,
                readonly: widget.readOnly,
                hintText: formatter.format(double.parse(project.getLoadedProject!.area!.replaceAll(",", ""))),
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateApplicantNameStatus(project.getLoadedProject!.applicantName!);
                },
                fillColor: shareProvider.projectInfo.applicantName! ? AppColors.mainThemeBlue : null,
                label: "Applicant Name:",
                maxLines: null,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.applicantName}",
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateEmailStatus(project.getLoadedProject!.email!);
                },
                fillColor: shareProvider.projectInfo.email! ? AppColors.mainThemeBlue : null,
                label: "Applicant Email:",
                maxLines: null,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.email}",
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateRegisteredOwnerStatus(project.getLoadedProject!.registeredOwners!);
                },
                fillColor: shareProvider.projectInfo.registeredOwner! ? AppColors.mainThemeBlue : null,
                label: "Registered Owner:",
                maxLines: null,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.registeredOwners}",
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateApplicantAddressStatus(project.getLoadedProject!.applicantAddress!);
                },
                fillColor: shareProvider.projectInfo.applicantAddress! ? AppColors.mainThemeBlue : null,
                label: "Applicant Address:",
                maxLines: null,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.applicantAddress}",
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateDebtStatus(project.getLoadedProject!.propertyDebt.toString());
                },
                fillColor: shareProvider.projectInfo.debt! ? AppColors.mainThemeBlue : null,
                label: "Property debt",
                maxLines: null,
                readonly: widget.readOnly,
                hintText:
                    '\$${formatter.format(double.parse(project.getLoadedProject!.propertyDebt.toString().replaceAll(",", "")))}',
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateBudgetStatus(project.getLoadedProject!.anticipatedBudget.toString());
                },
                fillColor: shareProvider.projectInfo.anticipatedBudget! ? AppColors.mainThemeBlue : null,
                label: "Anticipated Budget",
                maxLines: null,
                readonly: widget.readOnly,
                hintText:
                    '\$${formatter.format(double.parse(project.getLoadedProject!.anticipatedBudget.toString().replaceAll(",", "")))}',
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateDescriptionStatus(project.getLoadedProject!.description!);
                },
                fillColor: shareProvider.projectInfo.descripton! ? AppColors.mainThemeBlue : null,
                label: "Description",
                maxLines: 6,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.description}",
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateValueStatus(project.getLoadedProject!.currentPropertyValue.toString());
                },
                fillColor: shareProvider.projectInfo.currentValue! ? AppColors.mainThemeBlue : null,
                label: "Current Value",
                maxLines: null,
                readonly: widget.readOnly,
                hintText:
                    '\$${formatter.format(double.parse(project.getLoadedProject!.currentPropertyValue.toString().replaceAll(",", "")))}',
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateValueStatus(project.getLoadedProject!.projectLatestMarkedValue.toString());
                },
                fillColor: shareProvider.projectInfo.currentValue! ? AppColors.mainThemeBlue : null,
                label: "Market Value",
                maxLines: null,
                readonly: widget.readOnly,
                hintText:
                    '\$${formatter.format(double.parse(project.getLoadedProject!.projectLatestMarkedValue.toString().replaceAll(",", "")))}',
              ),
              // LabeledTextField(
              //   onTab: () {
              //     shareProvider.updateProjectAddressStatus(project.getLoadedProject!.projectAddress.toString());
              //   },
              //   fillColor: shareProvider.projectInfo.projectAddress! ? AppColors.mainThemeBlue : null,
              //   label: "Project Address",
              //   maxLines: null,
              //   readonly: widget.readOnly,
              //   hintText: "${project.getLoadedProject!.projectAddress}",
              // ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updatePostCodeStatus(project.getLoadedProject!.projectState.toString());
                },
                fillColor: shareProvider.projectInfo.postCode! ? AppColors.mainThemeBlue : null,
                label: "Postcode",
                maxLines: null,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.projectState}",
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateCrossCollStatus(project.getLoadedProject!.crossCollaterized.toString());
                },
                fillColor: shareProvider.projectInfo.crossColl! ? AppColors.mainThemeBlue : null,
                label: "Cross Collaterized",
                maxLines: null,
                readonly: widget.readOnly,
                hintText: project.getLoadedProject!.crossCollaterized == 1 ? "Yes" : "No",
              ),
              LabeledTextField(
                onTab: () {
                  shareProvider.updateExistingQStatus(project.getLoadedProject!.contractorSupplierDetails.toString());
                },
                fillColor: shareProvider.projectInfo.existingQ! ? AppColors.mainThemeBlue : null,
                label: "Existing Queries",
                maxLines: null,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.contractorSupplierDetails}",
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      );
    });
  }

  String compactNumberText(dynamic text) {
    final NumberFormat com;

    com = NumberFormat.decimalPattern()
      ..maximumFractionDigits = 0
      ..significantDigitsInUse = false;

    return com.format(text);
  }
}
