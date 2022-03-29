import 'dart:io';

import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/model/user_role_response/user_role_response.dart';
import 'package:fliproadmin/core/services/projects_service/projects_service.dart';
import 'package:fliproadmin/core/services/users_service/user_service.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:fliproadmin/core/view_model/auth_provider/auth_provider.dart';
import 'package:fliproadmin/core/view_model/project_provider/project_provider.dart';
import 'package:fliproadmin/ui/view/home_screen/home_screen.dart';
import 'package:fliproadmin/ui/widget/getx_dialogs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProjectsProvider with ChangeNotifier {
  String? _authToken;
  int _currentPage = 1;
  int? _totalPages;
  int _userRoleCurrentPage = 1;
  int? _userRoleTotalPage;
  int _searchUserCurrentPage = 1;
  int? _searchUserTotalPage;
  loadingState _isLoading = loadingState.loaded;
  loadingState get getLoadingState => _isLoading;
  String? query;
  List<UserRoleModel> _searchedUsers = [];
  List<UserRoleModel> _fetchedUsers = [];
  List<UserRoleModel> get getFetchedUsers => _fetchedUsers;
  List<UserRoleModel> get getSearcherUsers => _searchedUsers;
  int get getCurrentPage => _currentPage;
  late ProjectService _projectService;
  late UsersService _usersService;
  ProjectsProvider(String? authToken) {
    _projectService = ProjectService();
    _usersService = UsersService();
    _authToken = authToken;
  }

  removeProject({required int? projectId}) {
    try {
      _projects.removeWhere((element) {
        if (element.getProject.id == projectId) {
          return true;
        }
        return false;
      });
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  initToken(String token) {
    _authToken = token;
    notifyListeners();
  }

  setStateLoading() {
    _isLoading = loadingState.loading;
    notifyListeners();
  }

  setStateLoaded() {
    _isLoading = loadingState.loaded;
    notifyListeners();
  }

  List<ProjectProvider> _projects = [];

  List<ProjectProvider> get getProjects => _projects;

  Future<bool> addProject(
      {required Project project,
      required List<File> images,
      required List<MediaCompressionModel> media}) async {
    setStateLoading();
    GenericModel genericModel = await _projectService.addNewProject(
        accessToken: _authToken!,
        project: project,
        images: images,
        media: media);
    if (genericModel.statusCode == 200 ||
        genericModel.statusCode == 400 ||
        genericModel.statusCode == 401 ||
        genericModel.statusCode == 422) {
      GetXDialog.showDialog(
          title: genericModel.title, message: genericModel.message);

      if (genericModel.statusCode != 422 || genericModel.statusCode != 400) {
        Navigator.of(Get.context!)
            .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
      }
      return genericModel.success;
    }
    setStateLoaded();
    return false;
  }

  Future<bool> updateProject(
      {required Project project,
      required List<File> images,
      required List<MediaCompressionModel> media}) async {
    try{
      setStateLoading();
      GenericModel genericModel = await _projectService.updateProject(
          accessToken: _authToken!,
          project: project,
          images: images,
          media: media);
      if (genericModel.statusCode == 200 ||
          genericModel.statusCode == 400 ||
          genericModel.statusCode == 401 ||
          genericModel.statusCode == 422) {
        GetXDialog.showDialog(
            title: genericModel.title, message: genericModel.message);

        if (genericModel.statusCode != 422 || genericModel.statusCode != 400) {
          Navigator.of(Get.context!)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        }
        return genericModel.success;
      }

      return false;
    }finally{
      setStateLoaded();
    }
  }

  Future<void> fetchProjects(
      {bool initialLoading = false, bool fetchAssigned = false}) async {
    print("INITAIL FETCHS");
    try {
      if (_authToken != null) {
        setStateLoading();
        if (initialLoading) {
          _currentPage = 1;
          _projects.clear();
          _totalPages = null;
        }

        if ((_totalPages == null && _currentPage == 1) ||
            (_currentPage <= _totalPages!)) {
          GenericModel genericModel = await _projectService.getAllProjects(
              fetchAssigned: fetchAssigned,
              accessToken: _authToken!,
              page: _currentPage);

          if (genericModel.statusCode == 200) {
            ProjectResponse response = genericModel.returnedModel;
            if (response != null &&
                response.projectsList != null &&
                response.projectsList!.isNotEmpty) {
              _currentPage = response.currentPage! + 1;
              _totalPages = response.lastPage;

              ///IF INITIALLY LOADING DATA ASSIGN THE WHOLE LIST, PAGE 1
              if (initialLoading) {
                _projects = response.projectsList!;
              }

              ///LOADING PAGE 2 and
              else {
                _projects.addAll(response.projectsList!);
              }
            }
          }
        }
      } else {
        LogicHelper.unauthorizedHandler();
      }
    } finally {
      setStateLoaded();
    }
  }

  Future<void> fetchUsers(
      {bool initialLoading = false,
      required String userRole,
      int? projectId,
      String? searchQuery}) async {
    print("INITAIL FETCH USERS $userRole");
    try {
      setStateLoading();
      if (_authToken != null) {
        if (initialLoading) {
          _userRoleCurrentPage = 1;
          _fetchedUsers.clear();
          _userRoleTotalPage = null;
        }

        if ((_userRoleTotalPage == null && _userRoleCurrentPage == 1) ||
            (_userRoleCurrentPage <= _userRoleTotalPage!)) {
          GenericModel genericModel = await _usersService.getUserRoles(
              accessToken: _authToken!,
              page: _userRoleCurrentPage,
              projectId: projectId,
              searchQuery: searchQuery,
              role: userRole);

          if (genericModel.statusCode == 200) {
            UserRoleResponse response = genericModel.returnedModel;
            if (response != null &&
                response.data != null &&
                response.data!.users != null &&
                response.data!.users!.isNotEmpty) {
              _userRoleCurrentPage = response.data!.currentPage! + 1;
              _userRoleTotalPage = response.data!.lastPage;

              ///IF INITIALLY LOADING DATA ASSIGN THE WHOLE LIST, PAGE 1
              if (initialLoading) {
                _fetchedUsers = response.data!.users!;
              }

              ///LOADING PAGE 2 and
              else {
                _fetchedUsers.addAll(response.data!.users!);
              }
            }
          }
        }
      } else {
        LogicHelper.unauthorizedHandler();
      }
    } finally {
      setStateLoaded();
    }
  }

  Future<void> searchUsers(
      {bool initialLoading = false,
      required String userRole,
      int? projectId,
      String? searchQuery}) async {
    print("INITAIL FETCH USERS $userRole");
    try {
      if (_authToken != null) {
        setStateLoading();
        if (initialLoading) {
          query = searchQuery;
          _searchUserCurrentPage = 1;
          _searchedUsers.clear();
          _searchUserTotalPage = null;
        }

        if ((_searchUserTotalPage == null && _searchUserCurrentPage == 1) ||
            (_searchUserCurrentPage <= _searchUserTotalPage!)) {
          GenericModel genericModel = await _usersService.getUserRoles(
              accessToken: _authToken!,
              page: _searchUserCurrentPage,
              projectId: projectId,
              searchQuery: query,
              role: userRole);

          if (genericModel.statusCode == 200) {
            UserRoleResponse response = genericModel.returnedModel;
            if (response != null &&
                response.data != null &&
                response.data!.users != null &&
                response.data!.users!.isNotEmpty) {
              _searchUserCurrentPage = response.data!.currentPage! + 1;
              _searchUserTotalPage = response.data!.lastPage;

              ///IF INITIALLY LOADING DATA ASSIGN THE WHOLE LIST, PAGE 1
              if (initialLoading) {
                _searchedUsers = response.data!.users!;
              }

              ///LOADING PAGE 2 and
              else {
                _searchedUsers.addAll(response.data!.users!);
              }
            }
          }
        }
      } else {
        LogicHelper.unauthorizedHandler();
      }
    } finally {
      setStateLoaded();
    }
  }

  Future<bool> approveRejectProject(
      {required bool isApproved,
      required int projectId,
      bool doPop = true}) async {
    if (_authToken != null) {
      showLoadingDialog(title: "Loading...");
      GenericModel genericModel = await _projectService.projectApproval(
          accessToken: _authToken!, projectId: projectId, approve: isApproved);
      Navigator.pop(Get.context!, false);
      if (genericModel.statusCode == 200 ||
          genericModel.statusCode == 400 ||
          genericModel.statusCode == 401 ||
          genericModel.statusCode == 422) {
        GetXDialog.showDialog(
            title: genericModel.title, message: genericModel.message);
        if (genericModel.statusCode == 200 &&
            genericModel.returnedModel != null) {
          if (doPop) {
            Navigator.pop(Get.context!, true);
          }
          return true;
        } else {
          if (doPop) {
            Navigator.pop(Get.context!, false);
          }
          return false;
        }
      } else {
        if (doPop) {
          Navigator.pop(Get.context!, false);
        }
        return false;
      }
    }
    return false;
  }
}
