import 'package:country_code_picker/country_code_picker.dart';
import 'package:fliproadmin/core/model/registration_model/registration_model.dart';
import 'package:fliproadmin/core/services/users_service/user_service.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
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
  bool obsuredPassword = true;
  TextEditingController confirmPasswordController = TextEditingController();
  bool isBuilder = true;
  bool isHomeOwner = false;

  bool isFranchisee = false;

  bool isValuer = false;

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
          bannerText: "Add Member",
          automaticallyImplyLeading: true,
          showBothIcon: false,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 4.h,
                ),
                LabeledTextField(
                  label: 'Name',
                  textEditingController: nameController,
                  readonly: false,
                  maxlines: 1,
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
                  maxlines: 1,
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
                  maxlines: 1,
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
                  height: 3.5.h,
                ),
                Text(
                  "Phone",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AppColors.greyFontColor),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 15,
                      child: Container(
                        height: 6.h,
                        margin: const EdgeInsets.only(right: 4),
                        // constraints: BoxConstraints(minWidth: 10.w),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: CountryCodePicker(
                          onChanged: (value) {
                            setState(() {
                              countryCode = value.dialCode.toString();
                            });
                          },
                          textStyle: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.black),
                          backgroundColor: Colors.transparent,

                          dialogBackgroundColor: AppColors.mainThemeBlue,
                          dialogTextStyle: const TextStyle(color: Colors.white),
                          showFlagDialog: true,
                          textOverflow: TextOverflow.visible,

                          searchDecoration: customInputDecoration(
                              context: context,
                              hintText: 'Search',
                              usePrefixIcon: true,
                              prefixicon: 'default'),
                          // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                          initialSelection: 'US',
                          onInit: (code) {
                            countryCode = code!.dialCode.toString();
                            print('country code init: ');
                          },
                          dialogSize: Size(90.w, 80.h),

                          favorite: const ['+1', 'US'],
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
                    // Expanded(child: Container()),
                    Flexible(
                        flex: 30,
                        child: TextFormField(
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
                          decoration: customInputDecoration(
                              context: context, hintText: "Phone no."),
                        )),
                  ],
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
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Password*",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AppColors.greyFontColor),
                      // suffixIcon: InkWell(
                      //     onTap: () {
                      //       setState(() {
                      //         obsuredPassword = !obsuredPassword;
                      //       });
                      //     },
                      //     child: Icon(obsuredPassword
                      //         ? Icons.visibility
                      //         : Icons.visibility_off)),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(2.2.h),
                        child: SvgPicture.asset(
                          AppConstant.passwordIcon,
                        ),
                      ),
                    )),
                SizedBox(
                  height: 3.5.h,
                ),
                TextFormField(
                    obscureText: obsuredPassword,
                    controller: confirmPasswordController,
                    validator: (pass) {
                      if (pass != null) {
                        if (pass.trim().length < 6) {
                          return "Password must be at-least 6-digit long";
                        } else if (passwordController.text.trim() !=
                            confirmPasswordController.text.trim()) {
                          return "Password must match";
                        } else {
                          return null;
                        }
                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Password*",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(color: AppColors.greyFontColor),
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              obsuredPassword = !obsuredPassword;
                            });
                          },
                          child: Icon(obsuredPassword
                              ? Icons.visibility
                              : Icons.visibility_off)),
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
                 Text("Please User Role",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(color: AppColors.greyFontColor),),
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          title: const Text("Fanchisee"),
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          title: const Text("Builder"),
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
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
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
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
                Column(
                  children: [
                    MainButton(
                      height: 8.h,
                      width: 60.w,
                      buttonText: "Add Member",
                      callback: () {
                        if (_formKey.currentState!.validate()) {
                          RegistratingData registratingData = RegistratingData(
                            password: passwordController.text.trim(),
                            name: nameController.text,
                            address: addressController.text,
                            email: emailController.text.trim(),
                            phone: phoneController.text,
                            phoneCode: countryCode,
                            userType: LogicHelper.getUserTypefromBool(isBuilder: isBuilder, isFranchisee: isFranchisee, isHomeOwner: isHomeOwner, isvaluer: isValuer)
                          );

                          usersProvider.addMember(token:  Provider.of<UserProvider>(context,listen: false).getAuthToken, registratingData: registratingData);
                        }
                      },
                      userArrow: false,
                    ),
                  ],
                ),
                SizedBox(
                  height: 3.5.h,
                ),
              ],
            )),
      ),
    );
  }
}
