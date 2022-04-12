import 'dart:io';

import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/payment_response/draw_down_payment.dart'
    as ddpayment;
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/model/project_roles/project_roles.dart';
import 'package:fliproadmin/core/services/access_control_service/access_control_service.dart';
import 'package:fliproadmin/core/services/projects_service/projects_service.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/ui/view/view_unassigned_project/view_unassigned_project.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';

class LoadedProjectProvider with ChangeNotifier {
  Project? _loadedProject;
  Project? get getLoadedProject => _loadedProject;
  loadingState _isLoading = loadingState.loaded;
  loadingState get getLoadingState => _isLoading;
  late ProjectService _projectService;
  late AccessControlService _accessControlService;
  String? _authToken;
  LoadedProjectProvider(String? authToken) {
    _projectService = ProjectService();
    _accessControlService = AccessControlService();
    _authToken = authToken;
  }

  setStateLoading() {
    _isLoading = loadingState.loading;
    notifyListeners();
  }

  setStateLoaded() {
    print("SET STATE LOADING");
    _isLoading = loadingState.loaded;
    notifyListeners();
  }

  updatePaymentStatus(String status) {
    if (_loadedProject!.latestPaymentReq != null &&
        _loadedProject!.latestPaymentReq!.status != null) {
      _loadedProject!.latestPaymentReq!.status = status;
      notifyListeners();
    }
  }

  ProjectRoles getBuilderRoleById(int? builderId) {
    try {
      UserRoleModel userRoleModel =
          _loadedProject!.builder!.firstWhere((element) {
        if (element.id == builderId) {
          return true;
        }
        return false;
      });
      return userRoleModel.userRole ?? ProjectRoles();
    } catch (e) {
      print(e);
      return ProjectRoles();
    }
  }
  refresh(){
    fetchLoadedProject(_loadedProject!.id!);
  }
  ProjectRoles getValuerRoleById(int? valuerId) {
    try {
      UserRoleModel userRoleModel =
          _loadedProject!.valuers!.firstWhere((element) {
        if (element.id == valuerId) {
          return true;
        }
        return false;
      });
      return userRoleModel.userRole ?? ProjectRoles();
    } catch (e) {
      print(e);
      return ProjectRoles();
    }
  }

  ProjectRoles getHomeOwnerProjectRoles() {
    try {
      UserRoleModel userRoleModel = _loadedProject!.lead!;
      return userRoleModel.userRole ?? ProjectRoles();
    } catch (e) {
      print(e);
      return ProjectRoles();
    }
  }

  ProjectRoles getFrancshiseeProjectRoles() {
    try {
      UserRoleModel userRoleModel = _loadedProject!.franchisee!;
      return userRoleModel.userRole ?? ProjectRoles();
    } catch (e) {
      print(e);
      return ProjectRoles();
    }
  }



  fetchLoadedProject(int projectId) async {
    try {
      if (_authToken != null) {
        setStateLoading();
        GenericModel genericModel = await _projectService.getProjectById(
            accessToken: _authToken!, projectId: projectId);
        if (genericModel.statusCode == 200 &&
            genericModel.returnedModel != null) {
          _loadedProject = genericModel.returnedModel;
          notifyListeners();
        }
      }
    } finally {
      setStateLoaded();
    }
  }

  Future<bool> updateAccess(int userId, int projectId,
      ProjectRoles projectRoles, String routeName) async {
    ///
    try {
      setStateLoading();
      if (_authToken != null) {
        GenericModel genericModel = await _accessControlService.updateAccess(
            projectId: projectId,
            projectRoles: projectRoles,
            userId: userId,
            token: _authToken!);

        if (genericModel.statusCode == 200 ||
            genericModel.statusCode == 400 ||
            genericModel.statusCode == 401 ||
            genericModel.statusCode == 422) {
          GetXDialog.showDialog(
              title: genericModel.title, message: genericModel.message);
          if (genericModel.statusCode == 200) {
            _loadedProject = genericModel.returnedModel;
            print(_loadedProject!.toJson());
            Navigator.popUntil(Get.context!, ModalRoute.withName(routeName));
            projectRoles = ProjectRoles();
            return true;
          }

          return genericModel.success;
        }
        return false;
      } else {
        LogicHelper.unauthorizedHandler();
        return false;
      }
    } finally {
      setStateLoaded();
    }
  }
}
