import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'home_item.dart';
import 'home_screen.dart';

class HomePageBody extends StatelessWidget {
  HomePageBody({
    Key? key,
  }) : super(key: key);

  final List<home> projects = [
    home(
        name: "Kitchen Renovation",
        assigned: true,
        img: AppConstant.defaultProjectImage,
        loc: 'Muslim Town , Lahore'),
    home(
        name: "Kitchen Renovation",
        assigned: false,
        img: AppConstant.defaultProjectImage,
        loc: 'Muslim Town , Lahore'),
    home(
        name: "Home Renovation",
        assigned: false,
        img: AppConstant.defaultProjectImage,
        loc: 'Muslim Town , Lahore'),
    home(
        name: "Floor Renovation",
        assigned: true,
        img: AppConstant.defaultProjectImage,
        loc: 'Muslim Town , Lahore'),
    home(
        name: "Kitchen Renovation",
        assigned: true,
        img: AppConstant.defaultProjectImage,
        loc: 'Muslim Town , Lahore'),
    home(
        name:
            "Kitchen Renovation plus contruio sdvksdv skvklslkdv slkdvksdj sdjskdjvkls kjklsdjv skdj ",
        assigned: false,
        img: AppConstant.defaultProjectImage,
        loc:
            'Muslim Town , Lahore ,Punjab Pakistan , South Asia , Maiera loneod street KPK'),
    home(
        name: "Kitchen Renovation",
        assigned: true,
        img: AppConstant.defaultProjectImage,
        loc: 'Muslim Town , Lahore'),
    home(
        name: "Kitchen Renovation",
        assigned: false,
        img: AppConstant.defaultProjectImage,
        loc: 'Muslim Town , Lahore'),
    home(
        name: "Kitchen Renovation",
        assigned: true,
        img: AppConstant.defaultProjectImage,
        loc: 'Muslim Town , Lahore'),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 1.w,vertical: 1.h),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
           childAspectRatio: 1,
          // mainAxisExtent: 52.w,
          crossAxisSpacing: 8,
          mainAxisSpacing: 10,
        ),
        itemCount: projects.length,
        itemBuilder: (BuildContext ctx, index) {
          return HomeItem(project: projects[index]);
        });
  }
}
