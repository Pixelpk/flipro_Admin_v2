import 'package:fliproadmin/core/model/project_response/project_media_gallery_response.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/widget/custom_cache_network_image.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'image_preview.dart';

class ProjectImagesTab extends StatelessWidget {
  const ProjectImagesTab({Key? key, this.galleryMedia}) : super(key: key);
  final ProjectMediaGalleryResModel? galleryMedia;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadedProjectProvider>(
      builder: (ctx, loadedProjectProvider, c) {
        if (loadedProjectProvider.getLoadedProject == null || galleryMedia?.data?.projectImages == null) {
          return const Center(
            child: Text("No Images Available"),
          );
        }
        if (loadedProjectProvider.getLoadingState == LoadingState.loading) {
          return HelperWidget.progressIndicator();
        }
        return ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5, left: 10),
              child: Text("Project images"),
            ),
            (galleryMedia?.data?.projectImages ?? []).isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 1, crossAxisSpacing: 4, mainAxisSpacing: 4),
                    itemCount: galleryMedia?.data?.projectImages?.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ImagePreview(
                                      images: galleryMedia!.data!.projectImages!,
                                      index: index,
                                    )));
                          },
                          child: CustomCachedImage(
                            imageUrl: galleryMedia!.data!.projectImages![index],
                            fit: BoxFit.cover,
                            width: 100.w,
                          ));
                    })
                : SizedBox.shrink(),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5, left: 10),
              child: Text("Progress images"),
            ),
            (galleryMedia!.data!.progress ?? []).isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 1, crossAxisSpacing: 4, mainAxisSpacing: 4),
                    itemCount: galleryMedia!.data!.progress![0].photos!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ImagePreview(
                                      images: galleryMedia!.data!.progress![0].photos!,
                                      index: index,
                                    )));
                          },
                          child: CustomCachedImage(
                            imageUrl: galleryMedia!.data!.progress![0].photos![index],
                            fit: BoxFit.cover,
                            width: 100.w,
                          ));
                    })
                : SizedBox.shrink(),
            const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 5, left: 10),
              child: Text("Payment images"),
            ),
            (galleryMedia!.data!.paymentRequest ?? []).isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, childAspectRatio: 1, crossAxisSpacing: 4, mainAxisSpacing: 4),
                    itemCount: galleryMedia!.data!.paymentRequest![0].images!.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ImagePreview(
                                      images: galleryMedia!.data!.paymentRequest![0].images!,
                                      index: index,
                                    )));
                          },
                          child: CustomCachedImage(
                            imageUrl: galleryMedia!.data!.paymentRequest![0].images![index],
                            fit: BoxFit.cover,
                            width: 100.w,
                          ));
                    })
                : SizedBox.shrink(),
          ],
        );
      },
    );
  }
}
