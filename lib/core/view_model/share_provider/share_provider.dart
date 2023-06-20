import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/model/share_model/project_info_share_model.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ShareProvider extends ChangeNotifier {
  late ProjectInfoShareModel _infoShareModel;

  List<MediaCompressionModel> _selectedMedia = [];

  ProjectInfoShareModel get projectInfo => _infoShareModel;

  ShareProvider() {
    _infoShareModel = ProjectInfoShareModel();
  }

  clearCollectedData() {
    _selectedMedia.clear();
    _infoShareModel = ProjectInfoShareModel();
    notifyListeners();
  }

  addShareAbleMedia(MediaCompressionModel data) {
    print(_selectedMedia.length);
    print("SELECTED MEDIA");
    _selectedMedia.add(data);
  }

  removeShareAbleMedia(MediaCompressionModel data) {
    _selectedMedia.remove(data);
  }

  getCachedImages() async {
    showLoadingDialog(title: "Downloading...", showCancelIcon: true);
    DefaultCacheManager defaultCacheManager = DefaultCacheManager();
    print("sdsdf${_selectedMedia.length}");
    List<Future<String?>> futureRestulsList = _selectedMedia.map((e) async {
      print("path ${e.compressedVideoPath}");
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
    List<String?> shareAbleMedia =
        await Future.wait(List.generate(futureRestulsList.length, (index) => futureRestulsList[index]));
    Navigator.pop(Get.context!);
    print(shareAbleMedia.length);
    getProjectInfo();
    return shareAbleMedia;
  }

  String getProjectInfo() {
    String t = "";
    if (_infoShareModel.title!) {
      t = "$t\nTitle: ${_infoShareModel.titleText}";
    }
    if (_infoShareModel.descripton!) {
      t = "$t\nDescription: ${_infoShareModel.descriptonText}";
    }
    if (_infoShareModel.areaSelectecd!) {
      t = "$t\nArea: ${_infoShareModel.area}";
    }
    if (_infoShareModel.debt!) {
      t = "$t\nCurrent Debt: ${_infoShareModel.debtText}";
    }
    if (_infoShareModel.currentValue!) {
      t = "$t\nCurrent Value: ${_infoShareModel.currentValueText}";
    }
    if (_infoShareModel.email!) {
      t = "$t\nApplicant Email: ${_infoShareModel.emailText}";
    }
    if (_infoShareModel.anticipatedBudget!) {
      t = "$t\nAnticipated Budget: ${_infoShareModel.titleText}";
    }
    if (_infoShareModel.projectAddress!) {
      t = "$t\nProject Address: ${_infoShareModel.projectAddressText}";
    }
    if (_infoShareModel.applicantName!) {
      t = "$t\nApplicant Name: ${_infoShareModel.applicantNameText}";
    }
    if (_infoShareModel.applicantAddress!) {
      t = "$t\nApplicant Address: ${_infoShareModel.applicantAddressText}";
    }
    if (_infoShareModel.registeredOwner!) {
      t = "$t\nRegistered Owner: ${_infoShareModel.registeredOwnerText}";
    }
    if (_infoShareModel.crossColl!) {
      t = "$t\nCross Collaterized: ${_infoShareModel.crossCollText == 1 ? "Yes" : "No"}";
    }
    if (_infoShareModel.existingQ!) {
      t = "$t\nExisting Query: ${_infoShareModel.existingQText}";
    }
    if (_infoShareModel.postCode!) {
      t = "$t\nPostcode: ${_infoShareModel.PostCodeText}";
    }
    print("sdfsdf $t");
    return t;
  }

  share() {
    getCachedImages().then((image) {
      print(image.length);
      image as List<String?>;
      List<String> i = image.map((e) => "$e").toList();
      print(i.runtimeType);
      getProjectInfo();
      if (i != null && i.isNotEmpty) {
        Share.shareFiles(
          i,
          text: getProjectInfo(),
        );
      } else {
        Share.share(getProjectInfo());
      }
    });
  }

  updateTitleStatus(String title) {
    _infoShareModel.title = !_infoShareModel.title!;
    _infoShareModel.titleText = title;
    notifyListeners();
  }

  updateAreaStatus(String area) {
    _infoShareModel.areaSelectecd = !_infoShareModel.areaSelectecd!;
    _infoShareModel.area = area;
    notifyListeners();
  }

  updateEmailStatus(String email) {
    _infoShareModel.email = !_infoShareModel.email!;
    _infoShareModel.emailText = email;
    notifyListeners();
  }

  updateBudgetStatus(String budget) {
    _infoShareModel.anticipatedBudget = !_infoShareModel.anticipatedBudget!;
    _infoShareModel.anticipatedBudgetText = budget;
    notifyListeners();
  }

  updateDescriptionStatus(String description) {
    _infoShareModel.descripton = !_infoShareModel.descripton!;
    _infoShareModel.descriptonText = description;
    notifyListeners();
  }

  updateValueStatus(String value) {
    _infoShareModel.currentValueText = value;
    _infoShareModel.currentValue = !_infoShareModel.currentValue!;
    notifyListeners();
  }

  updateDebtStatus(String debt) {
    _infoShareModel.debtText = debt;
    _infoShareModel.debt = !_infoShareModel.debt!;
    notifyListeners();
  }

  updateProjectAddressStatus(String projectAddress) {
    _infoShareModel.projectAddressText = projectAddress;
    _infoShareModel.projectAddress = !_infoShareModel.projectAddress!;
    notifyListeners();
  }

  updateApplicantNameStatus(String debt) {
    _infoShareModel.applicantNameText = debt;
    _infoShareModel.applicantName = !_infoShareModel.applicantName!;
    notifyListeners();
  }

  updateApplicantAddressStatus(String debt) {
    _infoShareModel.applicantAddressText = debt;
    _infoShareModel.applicantAddress = !_infoShareModel.applicantAddress!;
    notifyListeners();
  }

  updateApplicantPhoneStatus(String debt) {
    _infoShareModel.applicantPhoneText = debt;
    _infoShareModel.applicantPhone = !_infoShareModel.applicantPhone!;
    notifyListeners();
  }

  updateRegisteredOwnerStatus(String debt) {
    _infoShareModel.registeredOwnerText = debt;
    _infoShareModel.registeredOwner = !_infoShareModel.registeredOwner!;
    notifyListeners();
  }

  updateExistingQStatus(String debt) {
    _infoShareModel.existingQText = debt;
    _infoShareModel.existingQ = !_infoShareModel.existingQ!;
    notifyListeners();
  }

  updateCrossCollStatus(String debt) {
    _infoShareModel.crossCollText = debt;
    _infoShareModel.crossColl = !_infoShareModel.crossColl!;
    notifyListeners();
  }

  updatePostCodeStatus(String debt) {
    _infoShareModel.PostCodeText = debt;
    _infoShareModel.postCode = !_infoShareModel.postCode!;
    notifyListeners();
  }
}
