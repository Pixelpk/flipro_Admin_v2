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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShareProvider(),
      child: Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment:  index < pages.length - 1 ?  MainAxisAlignment.spaceBetween: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: FloatingActionButton(
                  onPressed: () {


                    if (index > 0) {
                      setState(() {
                        index--;
                      });
                    }
                  },
                  child: const Icon(Icons.arrow_back_ios)),
            ),
            index < pages.length - 1 ?         Padding(
              padding: const EdgeInsets.all(12.0),
              child: FloatingActionButton(
                onPressed: () {
                  if (index < pages.length - 1) {
                    setState(() {
                      index++;
                    });
                  }
                  else {

                  }
                },
                child: index < pages.length - 1 ?  Icon(Icons.arrow_forward_ios): Icon(Icons.share)
              ),
            ): Expanded(
              child: MainButton(
                buttonText: "Share",
                width: 40.w,
                height: 7.h,
                userArrow: false,

              ),
            )
          ],
        ),
        body: pages.elementAt(index),
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Share"),
          actions: [const Text("Skip")],
        ),
      ),
    );
  }
}

class VideoSharing extends StatefulWidget {
  const VideoSharing({Key? key}) : super(key: key);

  @override
  _VideoSharingState createState() => _VideoSharingState();
}

class _VideoSharingState extends State<VideoSharing> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoadedProjectProvider>(builder: (ctx, loadedProject, c) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              "Select videos",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: GridView.builder(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4),
                itemCount: loadedProject.getLoadedProject!.videos!.length,
                itemBuilder: (BuildContext ctx, index) {
                  MediaCompressionModel video =
                      loadedProject.getLoadedProject!.videos![index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        video.isSelected = !video.isSelected!;
                      });
                    },
                    child: Stack(
                      alignment: Alignment.topRight,
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: video.thumbnailPath,
                          width: 100.w,
                          fit: BoxFit.cover,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(
                            video.isSelected!
                                ? Icons.check_box
                                : Icons.check_box_outline_blank_outlined,
                            color: AppColors.mainThemeBlue,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      );
    });
  }
}

class ImageSharing extends StatefulWidget {
  const ImageSharing({Key? key}) : super(key: key);

  @override
  State<ImageSharing> createState() => _ImageSharingState();
}

class _ImageSharingState extends State<ImageSharing> {
  @override
  void initState() {
    Provider.of<LoadedProjectProvider>(context, listen: false)
        .getLoadedProject!
        .photoGallery!
        .map((e) {})
        .toList();

    images.addAll(Provider.of<LoadedProjectProvider>(context, listen: false)
        .getLoadedProject!
        .photoGallery!
        .map((e) {
      return MediaCompressionModel(
        compressedVideoPath: '',
        thumbnailPath: e,
      );
    }).toList());
    setState(() {});
    super.initState();
  }

  List<MediaCompressionModel> images = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            "Select Images",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        Expanded(
          child: GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4),
              itemCount: images.length,
              itemBuilder: (BuildContext ctx, index) {
                MediaCompressionModel image = images[index];
                return InkWell(
                  onTap: () {
                    setState(() {
                      image.isSelected = !image.isSelected!;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: image.thumbnailPath,
                        width: 100.w,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                CircularProgressIndicator(
                                    value: downloadProgress.progress),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(
                          image.isSelected!
                              ? Icons.check_box
                              : Icons.check_box_outline_blank_outlined,
                          color: AppColors.mainThemeBlue,
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}

class ProjectInFoShare extends StatefulWidget {
  const ProjectInFoShare({
    Key? key,
    this.readOnly = true,
  }) : super(key: key);
  final bool readOnly;

  @override
  State<ProjectInFoShare> createState() => _ProjectInFoShareState();
}

class _ProjectInFoShareState extends State<ProjectInFoShare> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<LoadedProjectProvider, ShareProvider>(
        builder: (ctx, project, shareProvider, c) {
      if (project.getLoadingState == loadingState.loading) {
        return SizedBox(height: 70.h, child: HelperWidget.progressIndicator());
      }
      if (project.getLoadedProject == null &&
          project.getLoadingState == loadingState.loaded) {
        return SizedBox(
          height: 70.h,
          child: const Center(
            child: Text("Encounter an Error ,Please try again later"),
          ),
        );
      }
      return SizedBox(
        height: 100.h,
        width: 100.w,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  "Select Project Info",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              LabeledTextField(
                onTab: shareProvider.updateTitleStatus,
                label: "Project Title:",
                maxlines: null,
                readonly: widget.readOnly,
                fillColor: shareProvider.projectInfo.title!
                    ? AppColors.mainThemeBlue
                    : null,
                hintText: "${project.getLoadedProject!.title}",
              ),
              LabeledTextField(
                onTab: shareProvider.updateAreaStatus,
                fillColor: shareProvider.projectInfo.areaSelectecd!
                    ? AppColors.mainThemeBlue
                    : null,
                label: "Area:",
                maxlines: null,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.area}",
              ),
              LabeledTextField(
                onTab: shareProvider.updateEmailStatus,
                fillColor: shareProvider.projectInfo.email!
                    ? AppColors.mainThemeBlue
                    : null,
                label: "Applicant Email:",
                maxlines: null,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.email}",
              ),
              LabeledTextField(
                onTab: shareProvider.updateDebtStatus,
                fillColor: shareProvider.projectInfo.debt!
                    ? AppColors.mainThemeBlue
                    : null,
                label: "Property debt",
                maxlines: null,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.propertyDebt}",
              ),
              LabeledTextField(
                onTab: shareProvider.updateBudgetStatus,
                fillColor: shareProvider.projectInfo.anticipatedBudget!
                    ? AppColors.mainThemeBlue
                    : null,
                label: "Anticipated Budget",
                maxlines: null,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.anticipatedBudget}",
              ),
              LabeledTextField(
                onTab: shareProvider.updateDescriptionStatus,
                fillColor: shareProvider.projectInfo.descripton!
                    ? AppColors.mainThemeBlue
                    : null,
                label: "Description",
                maxlines: 6,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.description}",
              ),
              LabeledTextField(
                onTab: shareProvider.updateValueStatus,
                fillColor: shareProvider.projectInfo.currentValue!
                    ? AppColors.mainThemeBlue
                    : null,
                label: "Current Value",
                maxlines: null,
                readonly: widget.readOnly,
                hintText: "${project.getLoadedProject!.currentPropertyValue}",
              ),
            ],
          ),
        ),
      );
    });
  }
}
