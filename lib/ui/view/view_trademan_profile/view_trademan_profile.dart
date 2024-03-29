import 'package:fliproadmin/core/helper/call_helper.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/view/profile_screen/profile_appbar.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/custom_input_decoration.dart';
import 'package:fliproadmin/ui/widget/mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ViewTradeManProfile extends StatelessWidget {
  ViewTradeManProfile({Key? key}) : super(key: key);
  static const routeName = '/ViewTradeManProfile';
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _member = ModalRoute.of(context)!.settings.arguments as UserRoleModel;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
          bannerText: "Profile",
          automaticallyImplyLeading: true,
        ),
      ),
      body: SizedBox(
        height: 100.h,
        child: ListView(
          children: [
            ProfileAppbar(imageUrl: _member.avatar ?? ''),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: SingleChildScrollView(
                  child: SizedBox(
                      child: Column(children: [
                TextFormField(
                  readOnly: true,
                  controller: emailController,
                  decoration: customInputDecoration(
                      context: context, hintText: "${_member.name}", prefixIcon: AppConstant.person),
                ),
                SizedBox(height: 2.h),
                _member.userType == "builder" || _member.userType == "evaluator"
                    ? TextFormField(
                        readOnly: true,
                        controller: emailController,
                        decoration: customInputDecoration(
                            height: 18,
                            width: 18,
                            context: context,
                            hintText: "${_member.companyName}",
                            prefixIcon: AppConstant.companyIcon))
                    : Container(),
                _member.userType == "builder" || _member.userType == "evaluator" ? SizedBox(height: 2.h) : Container(),
                TextFormField(
                  readOnly: true,
                  controller: emailController,
                  decoration: customInputDecoration(
                      context: context, hintText: "${_member.email}", prefixIcon: AppConstant.emailIdon),
                ),
                SizedBox(height: 2.h),
                TextFormField(
                    readOnly: true,
                    onTap: () => launchCaller("${_member.phoneCode} ${_member.phone}"),
                    controller: emailController,
                    decoration: customInputDecoration(
                        context: context,
                        hintText:
                            MaskedTextController(mask: "+00 000 000 000", text: "${_member.phoneCode} ${_member.phone}")
                                .text,
                        prefixIcon: AppConstant.phoneIcon)),
                SizedBox(height: 2.h),
                TextFormField(
                    readOnly: true,
                    controller: emailController,
                    decoration: customInputDecoration(
                        height: 18,
                        width: 18,
                        context: context,
                        hintText: "${_member.address}",
                        prefixIcon: AppConstant.homeIcon)),
                Container(height: 10.h)
              ]))),
            ),
            Container(height: MediaQuery.of(context).viewInsets.bottom)
          ],
        ),
      ),
    );
  }
}
