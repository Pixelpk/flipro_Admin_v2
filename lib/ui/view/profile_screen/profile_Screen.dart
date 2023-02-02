import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/model/user_model/user_model.dart';
import 'package:fliproadmin/core/services/assets_provider/assets_provider.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/user_provider/user_provider.dart';
import 'package:fliproadmin/ui/view/profile_screen/profile_appbar.dart';
import 'package:fliproadmin/ui/view/profile_screen/update_password.dart';
import 'package:fliproadmin/ui/widget/custom_input_decoration.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:fliproadmin/ui/widget/my_profile_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController addressController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {

    initUserData();

    super.initState();
  }

  initUserData() {
    Provider.of<AssetProvider>(context, listen: false)
        .disposeSinglePickedImage();
    if (mounted) {
      setState(() {
        User userRoleModel =
            Provider.of<UserProvider>(context, listen: false).getCurrentUser;
        nameController = TextEditingController(text: userRoleModel.name);
        addressController = TextEditingController(text: userRoleModel.address);
        emailController = TextEditingController(text: userRoleModel.email);
        phoneController = TextEditingController(text: userRoleModel.phone);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    User userRoleModel = Provider.of<UserProvider>(context).getCurrentUser;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: 100.h,
        child: ListView(
          children: [
            MyProfileAppbar(
              pictureEditable: true,
              imageUrl: userRoleModel.avatar ?? '',
            ),
            SizedBox(
              height: 0.5.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nameController,
                        validator: (e) {
                          if (e != null && e.trim().isNotEmpty) {
                            return null;
                          }
                          return "Please add valid name";
                        },
                        decoration: customInputDecoration(
                            context: context,
                            hintText: userRoleModel.name ?? '',
                            prefixicon: AppConstant.person),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        controller: emailController,
                        readOnly: true,
                        decoration: customInputDecoration(
                            context: context,
                            hintText: userRoleModel.email ?? '',
                            prefixicon: AppConstant.emailIdon),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        controller: phoneController,
                        validator: (e) {
                          if (e != null && e.trim().isNotEmpty) {
                            return null;
                          }
                          return "Please add valid phone number";
                        },
                        decoration: customInputDecoration(
                            context: context,
                            hintText: userRoleModel.phone ?? '',
                            prefixicon: AppConstant.phoneIcon),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextFormField(
                        controller: addressController,
                        validator: (e) {
                          if (e != null && e.trim().isNotEmpty) {
                            return null;
                          }
                          return "Please add valid Address";
                        },
                        decoration: customInputDecoration(
                            context: context,
                            hintText: userRoleModel.address ?? '',
                            prefixicon: AppConstant.homeIcon),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      MainButton(
                        height: 6.h,
                        width: 90.w,
                        buttonText: "Update Password",
                        callback: () {
                          Navigator.of(context)
                              .pushNamed(UpdatePassword.routeName);
                        },
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      MainButton(
                        height: 7.h,
                        width: 60.w,
                        isloading: Provider.of<UserProvider>(context)
                                .getLoadingState ==
                            LoadingState.loading,
                        callback: () {
                          if (_formKey.currentState!.validate()) {
                            User user = User(
                              address: addressController.text,
                              phoneCode: userRoleModel.phoneCode,
                              name: nameController.text,
                              phone: phoneController.text,
                            );
                            Provider.of<UserProvider>(context, listen: false)
                                .updateUserProfile(user,
                                    pickedImage: Provider.of<AssetProvider>(
                                            context,
                                            listen: false)
                                        .getSinglePickedImage);

                          }
                        },
                        buttonText: "Save",
                        userArrow: false,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
