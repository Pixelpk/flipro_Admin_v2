import 'package:country_code_picker/country_code_picker.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/helper/number_formatter.dart';
import '../../widget/custom_input_decoration.dart';
import '../../widget/mask.dart';
import 'add_project_media_screen.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({Key? key, this.showAppBar = true, this.project, required this.isNewProject})
      : super(key: key);
  final bool showAppBar;
  final bool isNewProject;
  final ProjectProvider? project;

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  late TextEditingController applicantNameController;
  late MaskedTextController applicantPhoneController;
  late TextEditingController applicantEmailController;
  late TextEditingController applicantAddressController;
  late TextEditingController registeredOwnerController;
  late TextEditingController currentPropertyValue;
  late TextEditingController currentPropertyDebt;
  bool crossCollaterizedYes = false;
  bool crossCollaterizedNo = false;
  late Project project;
  final _formKey = GlobalKey<FormState>();
  bool rememberMe = false;

  String countryCode = "+92";

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
        body: ListView(physics: const BouncingScrollPhysics(), children: [
          SizedBox(
              child: Form(
                  key: _formKey,
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                      maxLines: 1,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: AppColors.mainThemeBlue,
                            value: rememberMe,
                            onChanged: (bool? value) {
                              setState(() {
                                rememberMe = value!;
                                print(rememberMe);
                                if (rememberMe == true) {
                                  registeredOwnerController.text = applicantNameController.text;
                                }
                              });
                            },
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Same as Registered owner",
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                                    color: Colors.black,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    LabeledTextField(
                      label: "",
                      maxLines: 1,
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
                    SizedBox(
                      height: 2.5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: TextFormField(
                        controller: applicantPhoneController,
                        validator: (e) {
                          if (e != null) {
                            if (e.isEmpty) {
                              return "Please add phone number";
                            }
                            return null;
                          }
                          return null;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: customInputDecoration(
                            prefix: Container(
                              height: 7.5.h,
                              margin: const EdgeInsets.only(right: 4),
                              // constraints: BoxConstraints(minWidth: 10.w),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                              child: SizedBox(
                                width: 120,
                                child: CountryCodePicker(
                                  onChanged: (value) {
                                    setState(() {
                                      countryCode = value.dialCode.toString();
                                    });
                                  },
                                  textStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
                                  backgroundColor: Colors.transparent,

                                  dialogBackgroundColor: AppColors.mainThemeBlue,
                                  dialogTextStyle: const TextStyle(color: Colors.white),
                                  showFlagDialog: true,
                                  textOverflow: TextOverflow.visible,

                                  searchDecoration: customInputDecoration(
                                      context: context, hintText: 'Search', usePrefixIcon: true, prefixText: 'default'),
                                  // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                  initialSelection: 'AU',
                                  onInit: (code) {
                                    countryCode = code!.dialCode.toString();
                                    print('country code init: ');
                                  },
                                  dialogSize: Size(90.w, 80.h),

                                  favorite: const ['+61', 'AU'],
                                  // optional. Shows only country name and flag
                                  showCountryOnly: false,
                                  // optional. Shows only country name and flag when popup is closed.
                                  showOnlyCountryWhenClosed: false,
                                  showFlag: true,
                                  flagWidth: 20,
                                  // optional. aligns the flag and the Text left
                                  alignLeft: true,
                                ),
                              ),
                            ),
                            context: context,
                            hintText: "Phone no."),
                      ),
                    ),
                    LabeledTextField(
                      label: "",
                      maxLines: 1,
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
                      maxLines: 1,
                      hintText: 'Registered Owner',
                      readonly: rememberMe == true ? true : false,
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
                            "Financial",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ),
                    LabeledTextField(
                      prefixText: "\$",
                      height: 18,
                      width: 18,
                      label: "",
                      maxLines: 1,
                      hintText: 'Current Property Value',
                      readonly: false,
                      textEditingController: currentPropertyValue,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      onChange: (input) {
                        if (input.isNotEmpty) {
                          String string = formatter.format(double.parse(input.replaceAll(",", "")));
                          currentPropertyValue.value = TextEditingValue(
                            text: string,
                            selection: TextSelection.collapsed(offset: string.length),
                          );
                        }
                      },
                      validation: (e) {
                        if (e == null || e.isEmpty) {
                          currentPropertyDebt.text = "0";
                          return null;
                        } else {
                          return null;
                        }
                      },
                    ),
                    LabeledTextField(
                      prefixText: "\$",
                      height: 18,
                      width: 18,
                      label: "",
                      maxLines: 1,
                      hintText: 'Current Property Debt.',
                      readonly: false,
                      textEditingController: currentPropertyDebt,
                      onChange: (input) {
                        if (input.isNotEmpty) {
                          String string = formatter.format(double.parse(input.replaceAll(",", "")));
                          currentPropertyDebt.value = TextEditingValue(
                            text: string,
                            selection: TextSelection.collapsed(offset: string.length),
                          );
                        }
                      },
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validation: (e) {
                        if (e == null || e.isEmpty) {
                          currentPropertyDebt.text = "0";
                          return null;
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
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                        child: Row(children: [
                          Text("Cross-Collaterized",
                              style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor)),
                          const Spacer(),
                          Row(children: [
                            Checkbox(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                                value: crossCollaterizedYes,
                                onChanged: (c) {
                                  setState(() {
                                    crossCollaterizedYes = c!;
                                    crossCollaterizedNo = false;
                                  });
                                }),
                            Text("YES",
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor))
                          ]),
                          Row(children: [
                            Checkbox(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
                                value: crossCollaterizedNo,
                                onChanged: (c) {
                                  setState(() {
                                    crossCollaterizedYes = false;
                                    crossCollaterizedNo = c!;
                                  });
                                }),
                            Text("NO",
                                style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor))
                          ])
                        ])),
                    SizedBox(height: 5.h),
                    MainButton(height: 7.h, callback: save, buttonText: "Continue", width: 60.w),
                    SizedBox(height: 5.h),
                  ])))
        ]));
  }

  initControllers() {
    if (widget.project != null) {
      project = widget.project!.getProject;
      applicantNameController = TextEditingController(text: project.applicantName);
      applicantEmailController = TextEditingController(text: project.email);
      applicantPhoneController = MaskedTextController(text: project.phone!, mask: '000 000 000 000');
      countryCode = project.phoneCode!;
      applicantAddressController = TextEditingController(text: project.applicantAddress!);
      registeredOwnerController =
          TextEditingController(text: rememberMe == true ? project.applicantName : project.registeredOwners!);
      currentPropertyDebt = TextEditingController(
        text: formatter.format(double.parse(project.propertyDebt!.toString().replaceAll(",", ""))),
      );
      currentPropertyValue = TextEditingController(
        text: formatter.format(double.parse(project.currentPropertyValue!.toString().replaceAll(",", ""))),
      );
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
      applicantPhoneController = MaskedTextController(mask: '000 000 000 000');
      applicantAddressController = TextEditingController();
      registeredOwnerController = TextEditingController();
      applicantEmailController = TextEditingController();
      currentPropertyDebt = TextEditingController(text: "0");
      currentPropertyValue = TextEditingController(text: "0");
    }
  }

  save() {
    if (_formKey.currentState!.validate() && (crossCollaterizedYes == true || crossCollaterizedNo == true)) {
      project.currentPropertyValue = int.tryParse(currentPropertyValue.text.replaceAll(",", ""));
      project.applicantName = applicantNameController.text.trim();
      project.email = applicantEmailController.text.trim();
      project.phone = applicantPhoneController.text.trim();
      project.phoneCode = countryCode;
      project.applicantAddress = applicantAddressController.text;
      project.registeredOwners = registeredOwnerController.text;
      project.propertyDebt = int.tryParse(currentPropertyDebt.text.replaceAll(",", ""));
      project.crossCollaterized = crossCollaterizedYes ? 1 : 0;

      Navigator.of(context).pushNamed(AddProjectMediaScreen.routeName,
          arguments: {"project": project, "newProject": widget.isNewProject});
    }
    if (crossCollaterizedYes == false && crossCollaterizedNo == false) {
      GetXDialog.showDialog(title: "Cross Collaterized", message: "Please add cross-collaterized status");
    }
  }
}
