import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/project_roles/project_roles.dart';
import 'package:fliproadmin/core/services/access_control_service/access_control_service.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/cupertino.dart';

class AccessControlProvider with ChangeNotifier {
  late ProjectRoles _projectRoles;
  LoadingState _isLoading = LoadingState.loaded;

  AccessControlProvider({ProjectRoles? projectRoles}) {
    _projectRoles = projectRoles ?? ProjectRoles();
    notifyListeners();
  }

  LoadingState get getLoadingState => _isLoading;
  ProjectRoles get getSelectedRoles => _projectRoles;

  setStateLoading() {
    _isLoading = LoadingState.loading;
    notifyListeners();
  }

  setStateLoaded() {
    _isLoading = LoadingState.loaded;
    notifyListeners();
  }

  ValueChanged<bool>? setviewAccess(bool roleStatus) {
    _projectRoles.view = roleStatus;
    notifyListeners();
  }

  ValueChanged<bool>? setAddValueAccess(bool roleStatus) {
    _projectRoles.addValue = roleStatus;
    notifyListeners();
  }

  ValueChanged<bool>? setAddNotesAccess(bool roleStatus) {
    _projectRoles.addNotes = roleStatus;
    notifyListeners();
  }

  ValueChanged<bool>? setUploadProgressAccess(bool roleStatus) {
    _projectRoles.uploadProgress = roleStatus;
    notifyListeners();
  }

  ValueChanged<bool>? setAddPhotosAccess(bool roleStatus) {
    print("PHOTO ACCESS $roleStatus");
    _projectRoles.addPhotos = roleStatus;

    notifyListeners();
  }

  ValueChanged<bool>? setRequestPaymentAccess(bool roleStatus) {
    _projectRoles.requestPayment = roleStatus;
    notifyListeners();
  }
}
