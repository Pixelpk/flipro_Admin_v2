import 'package:fliproadmin/core/model/project_response/project_media_gallery_response.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/view/project_overview_screen/project_media_gallery/project_video_preview.dart';
import 'package:fliproadmin/ui/widget/custom_cache_network_image.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProjectVideosTab extends StatelessWidget {
  const ProjectVideosTab({Key? key, this.galleryMedia}) : super(key: key);
  final ProjectMediaGalleryResModel? galleryMedia;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoadedProjectProvider>(
      builder: (ctx, loadedProjectProvider, c) {
        if (loadedProjectProvider.getLoadedProject == null ||
            galleryMedia?.data?.projectVideos == null) {
          return const Center(
            child: Text("No Media Available"),
          );
        }
        if (loadedProjectProvider.getLoadingState == LoadingState.loading) {
          return HelperWidget.progressIndicator();
        }
        return ListView(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5, left: 10),
              child: Text("Project videos"),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 4),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4),
              itemCount: galleryMedia?.data?.projectVideos!.length,
              itemBuilder: (BuildContext ctx, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => ProjectVideoPreview(
                              videos: galleryMedia!.data!.projectVideos!,
                              index: index,
                            )));
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomCachedImage(
                        imageUrl: galleryMedia!
                            .data!.projectVideos![index].thumbnail!,
                        fit: BoxFit.cover,
                        width: 100.w,
                      ),
                      const Icon(
                        Icons.play_circle_filled_outlined,
                        size: 38,
                      )
                    ],
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5, left: 10),
              child: Text("Progress videos"),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4),
                itemCount: galleryMedia!.data!.progress!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ProjectVideoPreview(
                                videos: galleryMedia!.data!.progress![0].videos ?? [],
                                index: index,
                              )));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomCachedImage(
                          imageUrl: galleryMedia!
                              .data!.progress![0].videos![index].thumbnail!,
                          fit: BoxFit.cover,
                          width: 100.w,
                        ),
                        const Icon(
                          Icons.play_circle_filled_outlined,
                          size: 38,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5, left: 10),
              child: Text("Payment videos"),
            ),
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(vertical: 4),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4),
                itemCount: galleryMedia!.data!.paymentRequest!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => ProjectVideoPreview(
                            videos: galleryMedia!.data!.paymentRequest![0].videos ?? [],
                            index: index,
                          )));
                    },
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CustomCachedImage(
                          imageUrl: galleryMedia!
                              .data!.paymentRequest![0].videos![index].thumbnail!,
                          fit: BoxFit.cover,
                          width: 100.w,
                        ),
                        const Icon(
                          Icons.play_circle_filled_outlined,
                          size: 38,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
