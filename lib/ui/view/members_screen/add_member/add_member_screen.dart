import 'package:country_code_picker/country_code_picker.dart';
import 'package:fliproadmin/core/model/registration_model/registration_model.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/users_provider/users_provider.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/custom_input_decoration.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../widget/custom_input.dart';

class AddMemberScreen extends StatefulWidget {
  AddMemberScreen({Key? key}) : super(key: key);

  static const routeName = '/AddMemberScreen';

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  String countryCode = "+92";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  bool obsuredPassword = true;
  TextEditingController confirmPasswordController = TextEditingController();
  bool isBuilder = true;
  bool isHomeOwner = false;
  bool isFranchisee = false;
  bool isValuer = false;

  late UsersProvider usersProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(bannerText: "Add Member", automaticallyImplyLeading: true, showBothIcon: false),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                ownerForm(),
                Column(
                  children: [
                    Consumer<UsersProvider>(builder: (ctx, usersProvider, c) {
                      this.usersProvider = usersProvider;
                      return MainButton(
                          height: 7.h,
                          width: 60.w,
                          buttonText: "Add Member",
                          isloading: usersProvider.getLoadingState == LoadingState.loading,
                          callback: () async => addMember(),
                          userArrow: false);
                    }),
                  ],
                ),
                SizedBox(height: 3.5.h)
              ],
            )),
      ),
    );
  }

  Widget ownerForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 4.h),
        LabeledTextField(
          label: 'Name',
          textEditingController: nameController,
          readonly: false,
          maxLines: 1,
          validation: (e) {
            if (e != null) {
              if (e.isEmpty) {
                return "Please Add name";
              } else if (e.length < 3) {
                return "Please should be at-least 4 digit long";
              }
              return null;
            }
          },
          hintText: "Member Name",
          preffixIcon: AppConstant.person,
        ),
        SizedBox(
          height: 3.h,
        ),
        LabeledTextField(
          label: 'Email',
          textEditingController: emailController,
          readonly: false,
          maxLines: 1,
          hintText: "Email Address",
          validation: (email) {
            Get.log("EMAIL $email");
            if (GetUtils.isEmail(email!.trim())) {
              return null;
            } else {
              return "Invalid Email";
            }
          },
          preffixIcon: AppConstant.emailIdon,
        ),
        SizedBox(
          height: 3.h,
        ),
        LabeledTextField(
          label: 'Address',
          readonly: false,
          maxLines: 1,
          textEditingController: addressController,
          hintText: "Address",
          validation: (e) {
            if (e != null) {
              if (e.isEmpty) {
                return "Address should not be empty";
              }
              return null;
            }
          },
          preffixIcon: AppConstant.homeIcon,
        ),
        SizedBox(
          height: 3.h,
        ),
        isValuer == true || isBuilder == true
            ? LabeledTextField(
                label: 'Company Name',
                readonly: false,
                maxLines: 1,
                textEditingController: companyController,
                hintText: "Company Name",
                validation: (e) {
                  if (e != null) {
                    if (e.isEmpty) {
                      return "Company Name should not be empty";
                    }
                    return null;
                  }
                },
              )
            : Container(),
        isValuer == true || isBuilder == true
            ? SizedBox(
                height: 3.5.h,
              )
            : Container(),
        Text(
          "Phone",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor),
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: phoneController,
          validator: (e) {
            if (e != null) {
              if (e.isEmpty) {
                return "Please add phone number";
              }
              return null;
            }
          },
          keyboardType: TextInputType.phone,
          decoration: customInputDecoration1(
              prefixIcon: Container(
                height: 7.5.h,
                margin: const EdgeInsets.only(right: 4),
                // constraints: BoxConstraints(minWidth: 10.w),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                child: Container(
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
                        context: context, hintText: 'Search', usePrefixIcon: true, prefixIcon: 'default'),
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
        SizedBox(
          height: 3.5.h,
        ),
        TextFormField(
            controller: passwordController,
            validator: (pass) {
              if (pass != null) {
                if (pass.trim().length < 6) {
                  return "Password must be at-least 6-digit long";
                } else {
                  return null;
                }
              }
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              fillColor: Colors.white,
              filled: true,
              hintText: "Password*",
              hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor),
              suffixIcon: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        setState(() {
                          passwordController.text = LogicHelper.generateRandomString(8);
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: Text(
                          "Generate Auto",
                          style: TextStyle(color: AppColors.mainThemeBlue),
                        ),
                      )),
                ],
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.all(2.2.h),
                child: SvgPicture.asset(
                  AppConstant.passwordIcon,
                ),
              ),
            )),
        SizedBox(
          height: 3.h,
        ),
        Text(
          "Please User Role",
          style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor),
        ),
        const SizedBox(
          height: 6,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CheckboxListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  title: const Text("Partners"),
                  value: isFranchisee,
                  onChanged: (bool? value) {
                    setState(() {
                      isBuilder = false;
                      isFranchisee = value!;
                      isValuer = false;
                      isHomeOwner = false;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CheckboxListTile(
                  selectedTileColor: AppColors.blueUnselectedTabColor,
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  title: const Text("Agents/Trades"),
                  value: isBuilder,
                  onChanged: (bool? value) {
                    setState(() {
                      isBuilder = value!;
                      isFranchisee = false;
                      isValuer = false;
                      isHomeOwner = false;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CheckboxListTile(
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  title: const Text("Valuer"),
                  value: isValuer,
                  onChanged: (bool? value) {
                    setState(() {
                      isBuilder = false;
                      isFranchisee = false;
                      isValuer = value!;
                      isHomeOwner = false;
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CheckboxListTile(
                  selectedTileColor: AppColors.blueUnselectedTabColor,
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  title: const Text("Home Owner"),
                  value: isHomeOwner,
                  onChanged: (bool? value) {
                    setState(() {
                      isBuilder = false;
                      isFranchisee = false;
                      isValuer = false;
                      isHomeOwner = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
      ],
    );
  }

  addMember() async {
    if (_formKey.currentState!.validate()) {
      RegistratingData registratingData = RegistratingData(
          password: passwordController.text.trim(),
          name: nameController.text,
          address: addressController.text,
          email: emailController.text.trim(),
          phone: phoneController.text,
          phoneCode: countryCode,
          companyName: companyController.text,
          userType: LogicHelper.getUserTypefromBool(
              isBuilder: isBuilder, isFranchisee: isFranchisee, isHomeOwner: isHomeOwner, isvaluer: isValuer));

      ///Create users and clear controller if success
      final args = ModalRoute.of(context)!.settings.arguments as Map;
      bool isSuccess = await usersProvider.addMember(
          appuser: args['appUsers'],
          createAssign: args['createAssign'],
          currentRoute: null,
          registratingData: registratingData);
      if (isSuccess) {
        passwordController.clear();
        nameController.clear();
        addressController.clear();
        emailController.clear();
        phoneController.clear();
        companyController.clear();
      }
    }
  }
}
