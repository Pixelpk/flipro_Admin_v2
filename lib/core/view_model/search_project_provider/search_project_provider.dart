
import 'package:flutter/foundation.dart';

import '../../model/generic_model/generic_model.dart';
import '../../model/search_project/search_project_response.dart';
import '../../services/projects_service/projects_service.dart';
import '../../utilities/logic_helper.dart';
import '../auth_provider/auth_provider.dart';
import '../project_provider/project_provider.dart';

class SearchProjectProvider extends ChangeNotifier {
  SearchProjectProvider() {
    projectService = ProjectService();
  }

  loadingState _isLoading = loadingState.loaded;
  loadingState get getLoadingState => _isLoading;
  late ProjectService projectService;
  List<ProjectProvider> _searchedProjects = [];
  clear(){
    _searchedProjects = [];
  }
  List<ProjectProvider> get getSearchedProjects => _searchedProjects;
  setStateLoading() {
    _isLoading = loadingState.loading;
    notifyListeners();
  }

  setStateLoaded() {
    _isLoading = loadingState.loaded;
    notifyListeners();
  }

  Future<void> searchProjects({String? searchQuery, String? authToken}) async {
    try {
      if (authToken != null) {
        setStateLoading();
        GenericModel genericModel = await projectService.searchProject(accessToken: authToken, query: searchQuery!);

        if (genericModel.statusCode == 200) {
          SearchProjectResponse response = genericModel.returnedModel;
          if (response != null && response.projectsList != null && response.projectsList!.isNotEmpty) {
            _searchedProjects = response.projectsList ?? [];
          }
        }
      } else {
        LogicHelper.unauthorizedHandler();
      }
    } finally {
      setStateLoaded();
    }
  }
}
