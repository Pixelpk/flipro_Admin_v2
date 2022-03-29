import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/model/share_model/project_info_share_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ShareProvider with ChangeNotifier {
  late ProjectInfoShareModel _infoShareModel;

  List<MediaCompressionModel> _selectedMedia = [];

  ProjectInfoShareModel get projectInfo => _infoShareModel;
  ShareProvider() {
    _infoShareModel = ProjectInfoShareModel();
  }

  getCachedImages() async {
    DefaultCacheManager defaultCacheManager = DefaultCacheManager();
    print("sdsdf${_selectedMedia.length}");
    List<Future<String?>> futureRestulsList =
    _selectedMedia.map((e) async {
      var file = await defaultCacheManager.getFileFromCache(e.compressedVideoPath);

      if (file != null && file.file != null) {
        return "${file.file.path}";
      } else {
        var file = await defaultCacheManager.downloadFile(e.compressedVideoPath);
        if (file != null && file.file != null) {
          return "${file.file.path}";
        }
      }
    }).toList();
    List<String?> shareAbleMedia = await Future.wait(List.generate(
        futureRestulsList.length, (index) => futureRestulsList[index]));
    print(shareAbleMedia.length);
    return shareAbleMedia;
  }


   updateTitleStatus(){
    _infoShareModel.title = !_infoShareModel.title!  ;  notifyListeners();
    print('sdcsdcsd');
  }
  updateAreaStatus(){
    _infoShareModel.areaSelectecd = !_infoShareModel.areaSelectecd!  ;
    notifyListeners();
  }
  updateEmailStatus(){
    _infoShareModel.email = !_infoShareModel.email!  ;  notifyListeners();
  }
  updateBudgetStatus(){
    _infoShareModel.anticipatedBudget = !_infoShareModel.anticipatedBudget!  ;  notifyListeners();
  }
  updateDescriptionStatus(){
    _infoShareModel.descripton = !_infoShareModel.descripton!  ;  notifyListeners();
  }
  updateValueStatus(){
    _infoShareModel.currentValue = !_infoShareModel.currentValue!  ;  notifyListeners();
  }
  updateDebtStatus(){
    _infoShareModel.debt = !_infoShareModel.debt!  ;  notifyListeners();
  }
}
