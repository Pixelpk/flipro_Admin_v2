import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/ui/widget/custom_input_decoration.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);
  static const routeName = '/updatePasswordScreen';

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  TextEditingController passwordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool obsurePassword = true;

  TextEditingController confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Update Password"),
          automaticallyImplyLeading: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 8.h,
                ),
                SvgPicture.asset(
                  AppConstant.passwordIcon,
                  height: 20.h,
                ),
                SizedBox(
                  height: 8.h,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: obsurePassword,
                  validator: (pass) {
                    if (pass != null) {
                      if (pass.trim().length < 6) {
                        return "Password must be atleast 6-digit long";
                      } else {
                        return null;
                      }
                    }
                  },
                  style: const TextStyle(color: AppColors.mainThemeBlue),
                  decoration: customInputDecoration(
                      context: context,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obsurePassword = !obsurePassword;
                          });
                        },
                        icon: Icon(obsurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                      hintText: "Password",
                      prefixicon: AppConstant.passwordIcon),
                ),

                SizedBox(
                  height: 3.h,
                ),

                ///CONFIRM PASSWORD FIELD
                TextFormField(
                  controller: confirmpasswordController,
                  style: const TextStyle(color: AppColors.mainThemeBlue),
                  validator: (confirmpass) {
                    if (confirmpass != null) {
                      if (confirmpass.trim().length < 6) {
                        return "Password must be atleast 6-digit long";
                      } else if (confirmpass.trim() !=
                          passwordController.text.trim()) {
                        return "Password must match";
                      } else {
                        return null;
                      }
                    }
                  },
                  decoration: customInputDecoration(
                      context: context,
                      hintText: "Re-type Password",
                      prefixicon: AppConstant.passwordIcon),
                ),
                SizedBox(
                  height: 15.h,
                ),
                Consumer<AuthProvider>(builder: (ctx, authProvider, c) {
                  return MainButton(
                    width: 80.w,
                    height: 7.h,
                    userArrow: false,

                    buttonText: "Update",
                    isloading:
                        authProvider.getLoadingState == loadingState.loading,
                    callback: () {
                      if (_formKey.currentState!.validate()) {
                        authProvider.updatePassword(password: passwordController.text.trim(), otp: args['otp'], email: args['email']);
                      }
                    },
                  );
                })
              ],
            ),
          ),
        ));
  }
}
