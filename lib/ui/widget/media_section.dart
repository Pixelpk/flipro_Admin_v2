import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/loaded_project/loaded_project.dart';
import 'package:fliproadmin/ui/view/image_gridview_screen/image_grid_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'colored_label.dart';
import 'custom_cache_network_image.dart';

class MediaSection extends StatelessWidget {
  const MediaSection({Key? key, required this.media}) : super(key: key);
  final MediaObject media;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadedProjectProvider>(builder: (ctx, project, c) {
      if (media == null && project.getLoadingState == LoadingState.loaded) {
        return Container();
      }
      if (project.getLoadingState == LoadingState.loading) {
        return Container();
      }
      return Column(
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Row(children: [
                Text("Media", style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppColors.greyFontColor)),
                const Spacer(),
                ColoredLabel(
                    callback: () {
                      Navigator.of(context).pushNamed(MediaViewAll.routeName, arguments: media);
                    },
                    color: AppColors.mainThemeBlue,
                    text: 'View all')
              ])),
          media.images != null
              ? Container(
                  margin: EdgeInsets.symmetric(vertical: 1.h),
                  width: 100.w,
                  height: 13.h,
                  child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
                      separatorBuilder: (context, index) => const SizedBox(width: 5),
                      itemBuilder: (context, index) {
                        return CustomCachedImage(
                          imageUrl: media.images![index],
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                        );
                      },
                      itemCount: media.images != null ? media.images!.length : 0,
                      scrollDirection: Axis.horizontal))
              : Container()
        ],
      );
    });
  }
}
