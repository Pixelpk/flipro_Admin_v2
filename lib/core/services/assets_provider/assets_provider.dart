import 'dart:io';
import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class AssetProvider extends ChangeNotifier {
  File? _singlePickedImage;
  final List<File> _compressedImage = [];
  final List<MediaCompressionModel> _compressedVidoesWithThumbnail = [];
  List<File> get getPickedImages => _compressedImage;
  List<MediaCompressionModel> get getCompressedVidoesWithThumbnail =>
      _compressedVidoesWithThumbnail;
  File? get getSinglePickedImage => _singlePickedImage;
  loadingState compressionProgress = loadingState.loaded;
  loadingState get getCompressionProgress => compressionProgress;
  setStateLoading() {
    compressionProgress = loadingState.loading;
    notifyListeners();
  }

  setStateLoaded() {
    compressionProgress = loadingState.loaded;
    notifyListeners();
  }

  imageCameraPicker(BuildContext context,
      {bool multiplePick = false, required ImageSource imageSource}) async {
   try {
      final ImagePicker _picker = ImagePicker();

      if (multiplePick == false) {
        print("SINGLE PICKER");
        XFile? xfile =
            await _picker.pickImage(source: imageSource, imageQuality: 40);
        if (xfile != null) {
          File compressedFile = await FlutterNativeImage.compressImage(
              xfile.path,
              quality: 40,
              percentage: 40);

          _compressedImage.add(compressedFile);
        }
      } else {
        print("MULTIPICKER PICKER");
        final List<XFile>? images =
            await _picker.pickMultiImage(imageQuality: 60);
        setStateLoading();
        if (images != null && images.isNotEmpty) {
          images.forEach((image) async {
            File compressedFile = await FlutterNativeImage.compressImage(
                image.path,
                quality: 40,
                percentage: 40);

            _compressedImage.add(compressedFile);
            notifyListeners();

          });

        }
      }
    }finally{
    setStateLoaded();
   }
  }

  singleImageCameraPicker(BuildContext context, ImageSource imageSource) async {
    final ImagePicker _picker = ImagePicker();

    print("SINGLE PICKER");
    XFile? xfile =
        await _picker.pickImage(source: imageSource, imageQuality: 40);
    if (xfile != null) {
      File compressedFile = await FlutterNativeImage.compressImage(xfile.path,
          quality: 60, percentage: 60,  );
      _singlePickedImage = compressedFile;
      notifyListeners();
    }
  }

  removedImage(File image) {
    _compressedImage.remove(image);
    notifyListeners();
  }

  removedVideo(MediaCompressionModel video) {
    _compressedVidoesWithThumbnail.remove(video);
    // _compressedVidoesThumnails.remove(video);
    notifyListeners();
  }

  videoCameraPicker(BuildContext context,
      {bool multiplePick = true, required ImageSource imageSource}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      XFile? xfile = await _picker.pickVideo(
        source: imageSource,
      );

      if (xfile != null) {
        final info = await VideoCompress.getMediaInfo(xfile.path);
        print("UNCOMRESSED VIDE SIZE ${info.filesize}");
        showLoadingDialog();
        MediaInfo? mediaInfo = await VideoCompress.compressVideo(
          xfile.path,
          frameRate: 20,
          quality: VideoQuality.Res640x480Quality,
          deleteOrigin: true, // It's false by default
        );

        if (mediaInfo != null && mediaInfo.path != null) {
          print("COMPRESSED VIDER SIZE ${mediaInfo.filesize}");
          File compressedVideo = File(mediaInfo.path!);
          if (multiplePick) {
            print(_compressedVidoesWithThumbnail.length);
            final thumbnailFile =
                await VideoCompress.getFileThumbnail(compressedVideo.path,
                    quality: 30,

                    // default(100)
                    position: -1 // default(-1)
                    );
            print("THUMBNAIL ${thumbnailFile.path}");
            _compressedVidoesWithThumbnail.add(MediaCompressionModel(
                compressedVideoPath: compressedVideo.path,
                thumbnailPath: thumbnailFile.path));
            print(_compressedVidoesWithThumbnail.length);
            Navigator.pop(Get.context!);
            setStateLoaded();
          }
        }
      }
    } catch (e) {
      print(e);
      Navigator.pop(Get.context!);
    }
  }

  clearAllMedia() {
    _singlePickedImage = null;
    _compressedImage.clear();
    _compressedVidoesWithThumbnail.clear();
    notifyListeners();
  }

  disposeSinglePickedImage() {
    _singlePickedImage = null;
  }
}
