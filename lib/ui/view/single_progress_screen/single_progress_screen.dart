import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/ui/widget/custom_app_bar.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/media_section.dart';
import 'package:fliproadmin/ui/widget/project_info.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SingleProgressScreen extends StatelessWidget {
  const SingleProgressScreen(
      {Key? key, this.showAppBar = true, this.progressModel})
      : super(key: key);
  static const routeName = '/SingleProgressScreen';
  final bool showAppBar;
  final ProgressModel? progressModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? PreferredSize(
              preferredSize: Size.fromHeight(LogicHelper.getCustomAppBarHeight),
              child: const CustomAppBar(
                automaticallyImplyLeading: true,
                bannerText: "Progress",
                showBothIcon: false,
                showShareIcon: false,
                showNoteIcon: false,
              ),
            )
          : null,
      body: ListView(
        physics: !showAppBar
            ? const NeverScrollableScrollPhysics()
            : const BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: !showAppBar ? 35.h : 50.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                LabeledTextField(
                  label: "Title",
                  hintText:  "${progressModel!.title!}",
                  maxlines: null,
                  readonly: false,
                ),
                LabeledTextField(
                  label: "Description",
                  maxlines: 6,
                  hintText: "${progressModel!.description!}",
                  readonly: false,
                ),
              ],
            ),
          ),

          ///TODO: PROGRESS MEDIA OBJECT
          MediaSection(
            media: MediaObject(
                images: progressModel!.photos ?? [],
                videos: progressModel!.videos ?? []),
          ),
        ],
      ),
    );
  }
}
