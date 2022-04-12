import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';




class ForgotPasswordScreen extends StatefulWidget {
  static const routeName = '/forgotPasswordScreen';

  const ForgotPasswordScreen({Key? key}) : super(key: key);
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController =
      TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          height: 90.h,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 15.h,
              ),
              const Text(
                  'One time password will be send \n to your email so you can recover your password',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 85.w,
                height: 10.h,
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (email) {
                      Get.log("EMAIL $email");
                      if (GetUtils.isEmail(email!.trim())) {
                        return null;
                      } else {
                        return "Invalid Email";
                      }
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 8.0),
                      border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 8.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                            const   BorderSide(color: AppColors.mainThemeBlue),
                          borderRadius: BorderRadius.circular(15),
                          gapPadding: 8.0),
                      hintText: 'Enter Your Email',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              authProvider.getLoadingState == loadingState.loading
                  ? HelperWidget.progressIndicator()
                  : MainButton(
                      buttonText: "Reset",
                      height: 7.h,
                      userArrow: false,
                      width: 85.w,
                      callback: () {
                        if (_formKey.currentState!.validate()) {
                          authProvider.forgotPassword(emailController.text.trim());
                        }
                      },

                    )
            ],
          )),
    );
  }
}
