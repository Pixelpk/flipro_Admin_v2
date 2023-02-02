import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/core/view_model/share_provider/share_provider.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:fliproadmin/ui/widget/labeledTextField.dart';
import 'package:fliproadmin/ui/widget/main_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import 'image_sharing.dart';
import 'project_info_sharing.dart';
import 'video_sharing.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen({Key? key}) : super(key: key);

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  List<Widget> pages = [
    const ProjectInFoShare(),
    const ImageSharing(),
    const VideoSharing()
  ];
  int index = 0;

  @override
  void initState() {
    Future.microtask(() => Provider.of<ShareProvider>(context, listen: false)
        .clearCollectedData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: index >= pages.length - 1
          ? Container(
              margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 2.h),
              child: MainButton(
                buttonText: "Share",
                width: 40.w,
                height: 7.h,
                userArrow: false,
                callback: () {
                  Provider.of<ShareProvider>(context, listen: false).share();
                },
              ),
            )
          : null,
      floatingActionButton:
          Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
        if ((loadedProject.getLoadedProject == null ||
                loadedProject.getLoadedProject!.videos == null) &&
            loadedProject.getLoadingState == LoadingState.loaded) {
          return Container();
        }
        if (loadedProject.getLoadingState == LoadingState.loading) {
          return Container();
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 40),
              child: FloatingActionButton(
                  heroTag: "btn01",
                  onPressed: () {
                    if (index > 0) {
                      setState(() {
                        index--;
                      });
                    }
                  },
                  child: const Icon(Icons.arrow_back_ios)),
            ),
            const Spacer(),
            index < pages.length - 1
                ? Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: FloatingActionButton(
                        heroTag: "btn02",
                        onPressed: () {
                          if (index < pages.length - 1) {
                            setState(() {
                              index++;
                            });
                          }
                        },
                        child: const Icon(Icons.arrow_forward_ios)),
                  )
                : Container()
          ],
        );
      }),
      body: pages.elementAt(index),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Share"),
      ),
    );
  }
}
