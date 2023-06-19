import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/ui/view/forgot_password_screen/forgot_password_screen.dart';
import 'package:fliproadmin/ui/view/home_screen/home_screen.dart';
import 'package:fliproadmin/ui/widget/custom_input_decoration.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../core/helper/remeber_me.dart';
import 'login_appbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obsuredPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool rememberMe = false;



  @override
  void initState() {
    super.initState();

    RememberMeHelper.getRememberMe().then((rememberMe) {
      if (rememberMe) {
        RememberMeHelper.getUsername().then((username) {
          RememberMeHelper.getPassword().then((password) {
            if(username !=null && password !=null){
              setState(() {
                emailController.text = username;
                passwordController.text = password;
                rememberMe = true;
              });
            }
          });
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 100.h,
          child: authProvider.getLoadingState == LoadingState.loading
              ? HelperWidget.progressIndicator()
              : Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const LoginAppBar(),
                      SizedBox(
                        height: 2.h,
                      ),
                      Image.asset(AppConstant.loginLogo, height: 25.h),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: 85.w,
                        child: TextFormField(
                          controller: emailController,
                          validator: (email) {
                            Get.log("EMAIL $email");
                            if (GetUtils.isEmail(email!.trim())) {
                              return null;
                            } else {
                              return "Invalid Email";
                            }
                          },
                          decoration: customInputDecoration(
                              context: context,
                              prefixIcon: AppConstant.person,
                              hintText: 'Email '),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      SizedBox(
                        width: 85.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextFormField(
                                obscureText: obsuredPassword,
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: AppColors.mainThemeBlue,
                                      value: rememberMe,
                                      onChanged: (bool? value) {
                                        setState(() {
                                          rememberMe = value!;
                                        });
                                      },
                                    ),
                                    GestureDetector(
                                      onTap: () {

                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Remember Me",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(context,
                                        ForgotPasswordScreen.routeName);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Forgot Password?",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MainButton(
                                  height: 6.h,
                                  width: 55.w,
                                  buttonText: "Login",
                                  callback: () {
                                    if (_formKey.currentState!.validate()) {
                                      if(rememberMe){
                                        RememberMeHelper.saveCredentials( emailController.text.trim(), passwordController.text.trim());
                                        RememberMeHelper.setRememberMe(true);
                                        authProvider.emailLogin(
                                            emailController.text.trim(),
                                            passwordController.text.trim());
                                      }
                                      else {
                                        RememberMeHelper.setRememberMe(false);
                                        authProvider.emailLogin(
                                            emailController.text.trim(),
                                            passwordController.text.trim());
                                      }

                                    }
                                    // Navigator.of(context)
                                    //     .pushNamed(HomeScreen.routeName);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
