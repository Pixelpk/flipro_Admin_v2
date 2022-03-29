import 'package:fliproadmin/core/model/user_model/user_model.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/widget/custom_input_decoration.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utilities/app_colors.dart';
import '../../../core/utilities/logic_helper.dart';
import '../../widget/custom_app_bar.dart';

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);
  static const routeName = '/UpdatePassword';
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
          automaticallyImplyLeading: true,
          bannerText: "Update Password",
          showBothIcon: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: oldPasswordController,
                validator: (e) {
                  if (e == null || e.trim().isEmpty) {
                    return "Old Password should not be empty";
                  }
                  if (e.length < 6) {
                    return "Password should be at-least 6 digit long";
                  }
                  return null;
                },
                decoration: customInputDecoration(
                    context: context,
                    hintText: "Old Password",
                    prefixicon: AppConstant.passwordIcon),
              ),
              SizedBox(
                height: 2.h,
              ),
              TextFormField(
                controller: newPasswordController,
                validator: (e) {
                  if (e == null || e.trim().isEmpty) {
                    return "New Password should not be empty";
                  }
                  if (e.length < 6) {
                    return "Password should be at-least 6 digit long";
                  }
                  if (newPasswordController.text !=
                      confirmPasswordController.text) {
                    return "Password does n't match";
                  }
                  return null;
                },
                decoration: customInputDecoration(
                    context: context,
                    hintText: "New Password",
                    prefixicon: AppConstant.passwordIcon),
              ),
              SizedBox(
                height: 2.h,
              ),
              TextFormField(
                controller: confirmPasswordController,
                validator: (e) {
                  if (e == null || e.trim().isEmpty) {
                    return "Password should not be empty";
                  }
                  if (e.length < 6) {
                    return "Password should be at-least 6 digit long";
                  }
                  if (newPasswordController.text !=
                      confirmPasswordController.text) {
                    return "Password does n't match";
                  }
                  return null;
                },
                decoration: customInputDecoration(
                    context: context,
                    hintText: "Confirm Password",
                    prefixicon: AppConstant.passwordIcon),
              ),
              SizedBox(
                height: 5.h,
              ),
              MainButton(
                height: 7.5.h,
                width: 60.w,
                isloading: Provider.of<UserProvider>(context).getLoadingState ==
                    loadingState.loading,
                callback: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<UserProvider>(context, listen: false)
                        .updatePassword(
                            newPassword: newPasswordController.text.trim(),
                            currentPassword: oldPasswordController.text.trim());
                  }
                },
                buttonText: "Update",
                userArrow: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
