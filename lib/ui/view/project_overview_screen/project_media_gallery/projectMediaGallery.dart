import 'package:fliproadmin/core/model/project_response/project_media_gallery_response.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/view/project_overview_screen/project_media_gallery/params/galleryMediaParams.dart';
import 'package:fliproadmin/ui/view/project_overview_screen/project_media_gallery/project_videos_tab.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'project_images_tab.dart';

class ProjectMediaGallery extends StatefulWidget {
  const ProjectMediaGallery({Key? key}) : super(key: key);
  static const routeName = '/projectMediaGallery';

  @override
  State<ProjectMediaGallery> createState() => _ProjectMediaGalleryState();
}

class _ProjectMediaGalleryState extends State<ProjectMediaGallery> {
  int segmentedControlValue = 0;

  // late MediaObject mediaObject ;
  late ProjectMediaGalleryResModel galleryMedia;

  // late List<String> projectImages;
  // late List<ProjectVideos> projectVideos;
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

  List<Widget> bodyWidgets = [];

  @override
  void initState() {
    Future.microtask(() {
      galleryMedia = ModalRoute.of(context)!.settings.arguments as ProjectMediaGalleryResModel;

      print(galleryMedia.toJson());
      bodyWidgets = [
        Expanded(
          child: ProjectImagesTab(
            galleryMedia: galleryMedia,
          ),
        ),
        Expanded(
          child: ProjectVideosTab(
            galleryMedia: galleryMedia,
          ),
        ),
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
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              segmentedControl(),
            ],
          ),
          bodyWidgets.elementAt(segmentedControlValue),
        ],
      ),
    );
  }
}
