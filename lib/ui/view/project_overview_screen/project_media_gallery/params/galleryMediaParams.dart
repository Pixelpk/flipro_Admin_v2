
import 'package:fliproadmin/core/model/project_response/project_media_gallery_response.dart';

class GalleryMediaParams {
  final List<String> projectImages;
  final List<ProjectVideos> projectVideos;

  GalleryMediaParams({required this.projectVideos, required this.projectImages});
}
