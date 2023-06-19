import 'package:decimal/decimal.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../core/helper/call_helper.dart';
import '../../core/utilities/app_colors.dart';
import '../../core/utilities/app_constant.dart';
import 'labeledTextField.dart';
import 'package:intl/intl.dart'; // for date format

class ProjectInfoSection extends StatelessWidget {
  ProjectInfoSection({
    Key? key,
    this.readOnly = false,
  }) : super(key: key);
  final bool readOnly;

  var formatter = NumberFormat('#,##0.' + "#" * 5);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadedProjectProvider>(builder: (ctx, project, c) {
      if (project.getLoadingState == LoadingState.loading) {
        return SizedBox(height: 70.h, child: HelperWidget.progressIndicator());
      }
      if (project.getLoadedProject == null &&
          project.getLoadingState == LoadingState.loaded) {
        return SizedBox(
          height: 70.h,
          child: const Center(
            child: Text("Encounter an Error ,Please try again later"),
          ),
        );
      }
      print("=====>${project.getLoadedProject!.contractorSupplierDetails}");
      print("=====>${project.getLoadedProject!.anticipatedBudget}");

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
                maxLines: null,
                readonly: readOnly,
                hintText: "${project.getLoadedProject!.projectAddress}"),
            SizedBox(height: 1.h),
            LabeledTextField(
                label: "Project Date:",
                maxLines: null,
                readonly: readOnly,
                hintText: DateFormat.yMMMMd().format(DateTime.tryParse(
                    project.getLoadedProject!.createdAt.toString())!)),
            SizedBox(height: 1.h),
            LabeledTextField(
                label: "Area(Square Metre):",
                maxLines: null,
                readonly: readOnly,
                hintText: formatter.format(double.parse(
                    project.getLoadedProject!.area!.replaceAll(",", "")))),
            SizedBox(height: 1.h),
            LabeledTextField(
              label: "Description",
              maxLines: 6,
              readonly: readOnly,
              hintText: "${project.getLoadedProject!.description}",
            ),
            SizedBox(
              height: 1.h,
            ),
            // LabeledTextField(
            //   label: "Project Title",
            //   maxLines: 1,
            //   readonly: readOnly,
            //   hintText: "${project.getLoadedProject!.title}",
            // ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Applicant Name:",
              maxLines: 1,
              readonly: true,
              hintText: project.getLoadedProject!.applicantName,
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
                inputFormatter: [ThousandsFormatter()],
                label: "Anticipated Budget:",
                maxLines: 1,
                readonly: true,
                hintText:
                    '\$${formatter.format(double.parse(project.getLoadedProject!.anticipatedBudget!.toString().replaceAll(",", "")))}'),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Applicant Address:",
              maxLines: 1,
              readonly: true,
              hintText: "${project.getLoadedProject!.applicantAddress}",
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              onTab: () {
                launchCaller('${project.getLoadedProject!.phone}');
              },
              label: "Applicant Phone:",
              maxLines: 1,
              readonly: true,
              hintText: '${project.getLoadedProject!.phone}',
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Registered Owner:",
              maxLines: 1,
              readonly: true,
              hintText: '${project.getLoadedProject!.registeredOwners}',
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Cross Collaterized:",
              maxLines: 1,
              readonly: true,
              hintText: project.getLoadedProject!.crossCollaterized == 1
                  ? "Yes"
                  : "No",
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Applicant email:",
              maxLines: 1,
              readonly: true,
              hintText: '${project.getLoadedProject!.email}',
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              label: "Property Debt:",
              maxLines: 1,
              readonly: true,
              hintText:
                  '\$${formatter.format(double.parse(project.getLoadedProject!.propertyDebt!.toString().replaceAll(",", "")))}', /*NumberFormat.currency(symbol: '\$').format((int.parse(project.getLoadedProject!.propertyDebt.toString())))*/
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              inputFormatter: [ThousandsFormatter()],
              label: "Existing Queries:",
              maxLines: 1,
              readonly: true,
              hintText:
                  project.getLoadedProject!.contractorSupplierDetails == '1'
                      ? 'Yes'
                      : 'No',
            ),
            SizedBox(
              height: 1.h,
            ),
            LabeledTextField(
              inputFormatter: [ThousandsFormatter()],
              label: "Postcode:",
              maxLines: 1,
              readonly: true,
              hintText: '${project.getLoadedProject!.projectState}',
            ),
            SizedBox(
              height: 1.h,
            ),
          ],
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

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "en_us");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
