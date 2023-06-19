import 'package:fliproadmin/ui/widget/custom_cache_network_image.dart';
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
            return  CustomCachedImage(
              imageUrl: widget.images[index],
              fit: BoxFit.cover,
            );


          }),
    );
  }
}
