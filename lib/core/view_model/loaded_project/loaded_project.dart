import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/model/project_roles/project_roles.dart';
import 'package:fliproadmin/core/services/access_control_service/access_control_service.dart';
import 'package:fliproadmin/core/services/projects_service/projects_service.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../ui/view/project_overview_screen/project_overview_Screen.dart';

class LoadedProjectProvider extends ChangeNotifier {
  Project? _loadedProject;

  Project? get  getLoadedProject => _loadedProject;
  LoadingState _isLoading = LoadingState.loaded;

  LoadingState get getLoadingState => _isLoading;
  late ProjectService _projectService;
  late AccessControlService _accessControlService;
  String? _authToken;

  LoadedProjectProvider(String? authToken) {
    _projectService = ProjectService();
    _accessControlService = AccessControlService();
    _authToken = authToken;
  }

  setStateLoading() {
    _isLoading = LoadingState.loading;
    notifyListeners();
  }

  setStateLoaded() {
    print("SET STATE LOADING");
    _isLoading = LoadingState.loaded;
    notifyListeners();
  }

  updatePaymentStatus(String status) {
    if (_loadedProject!.latestPaymentReq != null && _loadedProject!.latestPaymentReq!.status != null) {
      _loadedProject!.latestPaymentReq!.status = status;
      notifyListeners();
    }
  }

  ProjectRoles getBuilderRoleById(dynamic builderId) {
    try {
      print("BUI${builderId.runtimeType}");
      UserRoleModel userRoleModel = _loadedProject!.builder!.firstWhere((element) {
        if (element.id.toString() == builderId.toString()) {
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

  addProjectReview(bool isSatisfied, String review, {bool progressSatisfaction = false}) async {
    try {
      if (_authToken != null) {
        setStateLoading();
        GenericModel genericModel = await _projectService.addSatisfactionReview(
            accessToken: _authToken!,
            progressSatisfaction: progressSatisfaction,
            projectId: _loadedProject!.id.toString(),
            review: review,
            isSatisfied: isSatisfied ? 1 : 0);
        GetXDialog.showDialog(title: genericModel.title, message: genericModel.message);
        if (genericModel.statusCode == 200 && genericModel.returnedModel != null) {
          _loadedProject = genericModel.returnedModel;
          // notifyListeners();
        }
        return genericModel.statusCode;
      }
    } finally {
      setStateLoaded();
    }
  }

  UserRoleModel getBuilderById(dynamic builderId) {
    try {

      if (builderId.toString() == '00') {

        return _loadedProject!.builder![0];
      }
      UserRoleModel userRoleModel = _loadedProject!.builder!.firstWhere((element) {
        if (element.id.toString() == builderId.toString()) {
          return true;
        }
        return false;
      });
      print("lo ========> ${userRoleModel.toJson()}");
      return userRoleModel;
    } catch (e) {
      print(e);
      return UserRoleModel();
    }
  }

  refresh() {
    fetchLoadedProject(_loadedProject!.id!);
  }

  ProjectRoles getValuerRoleById(int? valuerId) {
    try {
      UserRoleModel userRoleModel = _loadedProject!.valuers!.firstWhere((element) {
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

  addProjectValue(String markedValue) async {
    try {
      if (_authToken != null) {
        setStateLoading();
        GenericModel genericModel = await _projectService.addProjectValue(
            accessToken: _authToken!, projectId: _loadedProject!.id!, markedValeu: markedValue);
        GetXDialog.showDialog(title: genericModel.title, message: genericModel.message);
        if (genericModel.statusCode == 200 && genericModel.returnedModel != null) {
          _loadedProject = genericModel.returnedModel;
          // notifyListeners();
        }
      }
    } finally {
      setStateLoaded();

      if (Get.currentRoute == ProjectOverviewScreen.routeName) {
        Navigator.pop(Get.context!);
      }
    }
  }

  closeProject(bool isSatisfied, String review, {bool progressSatisfaction = false}) async {
    ///IF ADD VALUE REMAKRS TRUE THEN THE PROJECT WILL BE CONSIDERED AS CLOSED
    try {
      if (_authToken != null) {
        setStateLoading();
        GenericModel genericModel = await _projectService.addSatisfactionReview(
            accessToken: _authToken!,
            progressSatisfaction: progressSatisfaction,
            projectId: _loadedProject!.id.toString(),
            review: review,
            isSatisfied: isSatisfied ? 1 : 0);
        // GetXDialog.showDialog(
        //     title: genericModel.title, message: genericModel.message);

        GetXDialog.showDialog(title: "Project Closed", message: "Project is moved to closed projects");
        if (genericModel.statusCode == 200 && genericModel.returnedModel != null) {
          _loadedProject = genericModel.returnedModel;
          // notifyListeners();
        }
        return genericModel.statusCode;
      }
    } finally {
      setStateLoaded();
    }
  }

  fetchLoadedProject(int projectId) async {
    try {
      if (_authToken != null) {
        setStateLoading();
        GenericModel genericModel =
            await _projectService.getProjectById(accessToken: _authToken!, projectId: projectId);
        if (genericModel.statusCode == 200 && genericModel.returnedModel != null) {
          _loadedProject = genericModel.returnedModel;
          notifyListeners();
        }
      }
    } finally {
      setStateLoaded();
    }
  }

  Future<bool> updateAccess(int userId, int projectId, ProjectRoles projectRoles, String routeName) async {
    ///
    try {
      if (_authToken != null) {
        setStateLoading();
        GenericModel genericModel = await _accessControlService.updateAccess(
            projectId: projectId, projectRoles: projectRoles, userId: userId, token: _authToken!);

        if (genericModel.statusCode == 200 ||
            genericModel.statusCode == 400 ||
            genericModel.statusCode == 401 ||
            genericModel.statusCode == 422) {
          GetXDialog.showDialog(title: genericModel.title, message: genericModel.message);
          if (genericModel.statusCode == 200) {
            _loadedProject = genericModel.returnedModel;
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
