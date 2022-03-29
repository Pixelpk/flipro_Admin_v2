import 'package:cached_network_image/cached_network_image.dart';
import 'package:fliproadmin/core/utilities/app_colors.dart';
import 'package:flutter/material.dart';

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

      progressIndicatorBuilder: (context, url, downloadProgress) => Container(
        height: 35,
        width: 35,
        padding: const EdgeInsets.all(45),
        child: CircularProgressIndicator(value: downloadProgress.progress),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error,color: AppColors.mainThemeBlue,),
    );
  }
}
