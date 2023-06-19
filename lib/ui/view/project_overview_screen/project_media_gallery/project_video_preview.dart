
import 'package:fliproadmin/core/model/project_response/project_media_gallery_response.dart';
import 'package:fliproadmin/ui/view/media_player/network_media_player.dart';
import 'package:flutter/material.dart';



class ProjectVideoPreview extends StatefulWidget {
  final List<ProjectVideos> videos;
  final int index;
  const ProjectVideoPreview({Key? key, required this.videos, required this.index})
      : super(key: key);

  @override
  State<ProjectVideoPreview> createState() => _ProjectVideoPreviewState();
}

class _ProjectVideoPreviewState extends State<ProjectVideoPreview> {
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
            return NetworkMediaPlayer(videoURL: widget.videos[index].file!);
          }),
    );
  }
}
