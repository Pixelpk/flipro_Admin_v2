import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:sizer/sizer.dart';

import 'add_project_media_screen.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key, this.showAppBar = true, this.project,required this.isNewProject})
      : super(key: key);
  final bool showAppBar;
  final bool isNewProject ;
  final ProjectProvider? project;
  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  late TextEditingController applicantNameController;
  late TextEditingController applicantPhoneController;
  late TextEditingController applicantEmailController;
  late TextEditingController applicantAddressController;
  late TextEditingController registeredOwnerController;
  late TextEditingController currentPropertyValue;
  late TextEditingController currentPropertyDebt;
  bool crossCollaterizedYes = false;
  bool crossCollaterizedNo = false;
  late Project project;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    initControllers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
          bannerText: "Add Project",
          showBothIcon: false,
          automaticallyImplyLeading: true,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 90.w,
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      children: [
                        Text(
                          "Applicant Information",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  LabeledTextField(
                    label: "",
                    maxlines: 1,
                    hintText: 'Applicant Name',
                    readonly: false,
                    keyboardType: TextInputType.name,
                    textEditingController: applicantNameController,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please Add Applicant's name";
                      } else if (e.length < 3) {
                        return "Applicant name should be at-least 3-digit long";
                      } else {
                        return null;
                      }
                    },
                  ),
                  LabeledTextField(
                    label: "",
                    maxlines: 1,
                    hintText: 'Email',
                    readonly: false,
                    textEditingController: applicantEmailController,
                    keyboardType: TextInputType.emailAddress,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please Add Applicant's email address";
                      } else if (!GetUtils.isEmail(e)) {
                        return "Please add valid email address";
                      } else {
                        return null;
                      }
                    },
                  ),
                  LabeledTextField(
                    label: "",
                    maxlines: 1,
                    hintText: 'Phone #',
                    readonly: false,
                    textEditingController: applicantPhoneController,
                    keyboardType: TextInputType.phone,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please Add Applicant's Phone number";
                      } else if (!GetUtils.isPhoneNumber(e)) {
                        return "Please add valid Phone number";
                      } else {
                        return null;
                      }
                    },
                  ),
                  LabeledTextField(
                    label: "",
                    maxlines: 1,
                    hintText: 'Applicant Address ',
                    readonly: false,
                    textEditingController: applicantAddressController,
                    keyboardType: TextInputType.streetAddress,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please Add Applicant's address";
                      } else {
                        return null;
                      }
                    },
                  ),
                  LabeledTextField(
                    label: "",
                    maxlines: 1,
                    hintText: 'Registered Owner',
                    readonly: false,
                    textEditingController: registeredOwnerController,
                    keyboardType: TextInputType.name,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please add registered owner's name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Container(
                    width: 90.w,
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    child: Row(
                      children: [
                        Text(
                          "Property Financial value",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ),
                  LabeledTextField(

                    label: "",
                    maxlines: 1,
                    hintText: 'Current Property Value',
                    readonly: false,
                    textEditingController: currentPropertyValue,
                    keyboardType: TextInputType.name,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please add current property value";
                      } else {
                        return null;
                      }
                    },
                  ),
                  LabeledTextField(

                    label: "",
                    maxlines: 1,
                    hintText: 'Current Property Debt.',
                    readonly: false,
                    textEditingController: currentPropertyDebt,
                    keyboardType: TextInputType.name,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please add current property value";
                      } else {
                        return null;
                      }
                    },
                  ),
                  /*LabeledTextField(
                    label: "",
                    maxlines: 1,
                    hintText: 'Current Property Value',
                    textEditingController: currentPropertyValue,
                    keyboardType: TextInputType.number,
                    inputFormatter: FilteringTextInputFormatter.digitsOnly,
                    readonly: false,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please add current property value";
                      } else {
                        return null;
                      }
                    },
                  ),
                  LabeledTextField(
                    label: "",
                    maxlines: 1,
                    hintText: 'Current Property Debt.',
                    textEditingController: currentPropertyDebt,
                    inputFormatter: FilteringTextInputFormatter.digitsOnly,
                    keyboardType: TextInputType.number,
                    readonly: false,
                    validation: (e) {
                      if (e == null || e.isEmpty) {
                        return "Please add current property value";
                      } else {
                        return null;
                      }
                    },
                  ),*/
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: 90.w,
                    height: 8.h,
                    padding: EdgeInsets.symmetric(horizontal: 3.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Cross-Collaterized",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: AppColors.greyFontColor),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60)),
                                value: crossCollaterizedYes,
                                onChanged: (c) {
                                  setState(() {
                                    crossCollaterizedYes = c!;
                                    crossCollaterizedNo = false;
                                  });
                                }),
                            Text(
                              "YES",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: AppColors.greyFontColor),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(60)),
                                value: crossCollaterizedNo,
                                onChanged: (c) {
                                  setState(() {
                                    crossCollaterizedYes = false;
                                    crossCollaterizedNo = c!;
                                  });
                                }),
                            Text(
                              "NO",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: AppColors.greyFontColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  MainButton(
                    height: 7.h,
                    callback:save,
                    buttonText: "Continue",
                    width: 60.w,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  initControllers() {
    if (widget.project != null) {
      project = widget.project!.getProject;
      applicantNameController =
          TextEditingController(text: project.applicantName);
      applicantEmailController = TextEditingController(text: project.email);
      applicantPhoneController = TextEditingController(text: project.phone!);
      applicantAddressController =
          TextEditingController(text: project.applicantAddress!);
      registeredOwnerController =
          TextEditingController(text: project.registeredOwners!);
      currentPropertyDebt =
          TextEditingController(text: project.propertyDebt.toString());
      currentPropertyValue =
          TextEditingController(text: project.currentPropertyValue.toString());
      if (project.crossCollaterized == 0) {
        crossCollaterizedYes = false;
        crossCollaterizedNo = true;
      }
      if (project.crossCollaterized == 1) {
        crossCollaterizedYes = true;
        crossCollaterizedNo = false;
      }
    } else {
      project = Project();
      applicantNameController = TextEditingController();
      applicantPhoneController = TextEditingController(text: "+61");
      applicantAddressController = TextEditingController();
      registeredOwnerController = TextEditingController();
      applicantEmailController = TextEditingController();
      currentPropertyDebt = TextEditingController();
      currentPropertyValue = TextEditingController();
    }
  }
   save () {
     if (_formKey.currentState!.validate() &&
         (crossCollaterizedYes == true ||
             crossCollaterizedNo == true)) {
       project.currentPropertyValue =
           int.tryParse(currentPropertyValue.text);
       project.applicantName =
           applicantNameController.text.trim();
        project.email = applicantEmailController.text.trim();
       project.phone = applicantPhoneController.text.trim();
       project.applicantAddress =
           applicantAddressController.text;
       project.registeredOwners =
           registeredOwnerController.text;
       project.propertyDebt =
           int.tryParse(currentPropertyDebt.text);
       project.crossCollaterized =
       crossCollaterizedYes ? 1 : 0;

       Navigator.of(context).pushNamed(
           AddProjectMediaScreen.routeName,
           arguments:{
             "project":project,
             "newProject":widget.isNewProject
           } );
     }
     if (crossCollaterizedYes == false &&
         crossCollaterizedNo == false) {
       GetXDialog.showDialog(
           title: "Cross Collaterized",
           message: "Please add cross-collaterized status");
     }
   }
}
