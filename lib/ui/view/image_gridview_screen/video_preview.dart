import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/ui/view/media_player/network_media_player.dart';
import 'package:flutter/material.dart';

class VideoPreview extends StatefulWidget {
  final List<MediaCompressionModel> videos;
  final int index;
  const VideoPreview({Key? key, required this.videos, required this.index})
      : super(key: key);

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
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
      body: PageView.builder(
          controller: _pageController,
          itemCount: widget.videos.length,
          itemBuilder: (ctz, index) {
            return NetworkMediaPlayer(videoURL: widget.videos[index].compressedVideoPath);
          }),
    );
  }
}
