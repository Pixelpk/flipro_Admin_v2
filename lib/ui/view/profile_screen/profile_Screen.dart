import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/view/profile_screen/profile_appbar.dart';
import 'package:fliproadmin/ui/widget/custom_input_decoration.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({Key? key}) : super(key: key);
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: 100.h,
        child: ListView(
          children: [
            const ProfileAppbar(pictureEditable: true,),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller:  passwordController ,
                      decoration: customInputDecoration(
                          context: context,
                          hintText: "Name",
                          prefixicon: AppConstant.person),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(      controller:  passwordController ,
                      decoration: customInputDecoration(
                          context: context,
                          hintText: "Email",
                          prefixicon: AppConstant.emailIdon),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(      controller:  passwordController ,
                      decoration: customInputDecoration(
                          context: context,
                          hintText: "Phone No.",
                          prefixicon: AppConstant.phoneIcon),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(      controller:  passwordController ,
                      decoration: customInputDecoration(
                          context: context,
                          hintText: "Old Password",
                          prefixicon: AppConstant.passwordIcon),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(      controller:  passwordController ,
                      decoration: customInputDecoration(
                          context: context,
                          hintText: "New Password",
                          prefixicon: AppConstant.passwordIcon),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextFormField(      controller:  passwordController ,
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
                      callback: () {},
                      buttonText: "Update",
                      userArrow: false,
                    ),

                  ],
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
