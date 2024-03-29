import 'package:cached_network_image/cached_network_image.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/utilities/app_constant.dart';

class CustomCachedImage extends StatelessWidget {
  const CustomCachedImage(
      {Key? key, required this.imageUrl, this.fit, this.height, this.width})
      : super(key: key);

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      fit: fit,
      height: height,

      progressIndicatorBuilder: (context, url, downloadProgress) =>SizedBox(
        width: width,
        height: height,
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child:Image.asset(AppConstant.defaultProjectImage,height: height,width: width,)
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error,color: AppColors.mainThemeBlue,),
    );
  }
}
