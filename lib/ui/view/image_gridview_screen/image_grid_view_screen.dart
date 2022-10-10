import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/view/image_gridview_screen/video_tab_page.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
//
// class ImageGridViewScreen extends StatelessWidget {
//   const ImageGridViewScreen({Key? key}) : super(key: key);
//   static const routeName = '/imageGridViewScreen';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
//         child: const CustomAppBar(
//           automaticallyImplyLeading: true,
//           bannerText: "Project Media",
//           showBothIcon: false,
//         ),
//       ),
//       body:
//
//     );
//   }
// }

import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/ui/widget/approve_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'images_tab_page.dart';


class MediaViewAll extends StatefulWidget {
  const MediaViewAll({Key? key}) : super(key: key);
  static const routeName = '/imageGridViewScreen';

  @override
  State<MediaViewAll> createState() =>
      _MediaViewAllState();
}

class _MediaViewAllState extends State<MediaViewAll> {
  int segmentedControlValue = 0;
 late MediaObject mediaObject ;
  Widget segmentedControl() {


    return Container(
      width: 85.w,
      padding: const EdgeInsets.all(8.0),
      child: CupertinoSlidingSegmentedControl(
          groupValue: segmentedControlValue,
          padding: EdgeInsets.zero,
          backgroundColor: AppColors.blueUnselectedTabColor,
          children: const <int, Widget>{
            0: Text('Images'),
            1: Text('Videos'),
          },
          onValueChanged: (value) {
            setState(() {
              segmentedControlValue = value as int;
            });
          }),
    );
  }

late  List<Widget> bodyWidgets ;

  @override
  void initState() {
    Future.microtask(() {
      mediaObject =  ModalRoute.of(context)!.settings.arguments as MediaObject;
      bodyWidgets = [
        Expanded(child: ImagesTabBody(mediaObject: mediaObject,)),
        Expanded(child: VideosTabBody(mediaObject: mediaObject,))
      ];
      setState(() {});
    });
    super.initState();
  }
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              segmentedControl(),
            ],
          ),
          bodyWidgets.elementAt(segmentedControlValue)
        ],
      ),
    );
  }
}