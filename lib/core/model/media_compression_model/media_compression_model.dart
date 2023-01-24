class MediaCompressionModel {
  late String thumbnailPath;
  late String compressedVideoPath;
  bool? isSelected = false;

  MediaCompressionModel({required this.compressedVideoPath, required this.thumbnailPath, this.isSelected = false});

  MediaCompressionModel.fromJson(Map<String, dynamic> json) {
    compressedVideoPath = json['file'];
    thumbnailPath = json['thumbnail'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['video'] = compressedVideoPath;
    data['thumbnail'] = thumbnailPath;
    return data;
  }
}

class MediaObject {
  List<String>? images;
  List<MediaCompressionModel>? videos;

  MediaObject({this.videos, this.images});
}
