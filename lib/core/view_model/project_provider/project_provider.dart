import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:flutter/cupertino.dart';

class ProjectProvider with ChangeNotifier {
  late Project _project;
  ProjectProvider( project) {
    _project = project;
  }

  Project get getProject => _project ;

}
