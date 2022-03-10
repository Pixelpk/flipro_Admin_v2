import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ImageGridViewScreen extends StatelessWidget {
  const ImageGridViewScreen({Key? key}) : super(key: key);
  static const routeName = '/imageGridViewScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
        child: const CustomAppBar(
          automaticallyImplyLeading: true,
          bannerText: "Project Media",
          showBothIcon: false,

        ),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.symmetric( vertical: 4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
          crossAxisSpacing: 4,
            mainAxisSpacing: 4
          ),
          itemCount: 20,
          itemBuilder: (BuildContext ctx, index) {
            return Image.asset(AppConstant.defaultProjectImage,width: 100.w,fit: BoxFit.cover,);
          }),
    );
  }
}
