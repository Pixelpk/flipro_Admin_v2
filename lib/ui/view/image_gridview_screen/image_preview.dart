import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePreview extends StatefulWidget {
  final List<String> images;
  final int index;
  const ImagePreview({Key? key, required this.images, required this.index})
      : super(key: key);

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: widget.index);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor:Colors.black,
      ),
      body: PageView.builder(
          controller: _pageController,
          itemCount: widget.images.length,
          itemBuilder: (ctz, index) {
            return
              CachedNetworkImage(
                imageUrl:           widget.images[index],


                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              );

          }),
    );
  }
}
