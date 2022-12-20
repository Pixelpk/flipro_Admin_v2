import '../../view_model/project_provider/project_provider.dart';
import '../project_response/project_response.dart';

class SearchProjectResponse {
  String? message;
  List<ProjectProvider>? projectsList;

  SearchProjectResponse({this.message, this.projectsList});

  SearchProjectResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      projectsList = <ProjectProvider>[];
      json['data'].forEach((v) {
        projectsList!.add(ProjectProvider(Project.fromJson(v)));
      });
    }
  }

}