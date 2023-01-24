import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/widget/custom_cache_network_image.dart';
import 'package:fliproadmin/ui/widget/helper_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'image_preview.dart';

class ImagesTabBody extends StatelessWidget {
  const ImagesTabBody({Key? key, required this.mediaObject}) : super(key: key);
  final MediaObject mediaObject;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadedProjectProvider>(builder: (ctx, loadedProjectProvider, c) {
      if (loadedProjectProvider.getLoadedProject == null || mediaObject.images == null) {
        return const Center(
          child: Text("No Images Available"),
        );
      }
      if (loadedProjectProvider.getLoadingState == LoadingState.loading) {
        return HelperWidget.progressIndicator();
      }
      return GridView.builder(
          padding: const EdgeInsets.symmetric(vertical: 4),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1, crossAxisSpacing: 4, mainAxisSpacing: 4),
          itemCount: mediaObject.images!.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => ImagePreview(
                            images: mediaObject.images!,
                            index: index,
                          )));
                },
                child: CustomCachedImage(
                  imageUrl: mediaObject.images![index],
                  fit: BoxFit.cover,
                  width: 50.w,
                ));
          });
    });
  }
}
