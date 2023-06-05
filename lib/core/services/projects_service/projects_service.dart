import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fliproadmin/core/model/exception_model/exception_model.dart';
import 'package:fliproadmin/core/model/generic_model/generic_model.dart';
import 'package:fliproadmin/core/model/media_compression_model/media_compression_model.dart';
import 'package:fliproadmin/core/model/project_response/project_media_gallery_response.dart';
import 'package:fliproadmin/core/model/project_response/project_response.dart';
import 'package:fliproadmin/core/utilities/app_constant.dart';
import 'package:fliproadmin/core/utilities/env.dart';
import 'package:fliproadmin/core/utilities/logic_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../model/search_project/search_project_response.dart';

class ProjectService {
  Future<GenericModel> addProjectValue(
      {required String accessToken, required int projectId, required String markedValeu}) async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $accessToken'};
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ENV.baseURL}/api/projects/value?project_id=$projectId&value=$markedValeu'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      print(res);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return GenericModel(
            returnedModel: Project.fromJson(jsonDecode(res)['data']),
            success: true,
            title: "Project value added",
            message: "Project value added",
            statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            title: exceptionModel.errors!.errorList![0].error,
            statusCode: 422,
            message: exceptionModel.errors!.errorList![0].message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: "Invalid Credentials");
      } else {
        print("sdfsdf");
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: response.statusCode,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    } catch (e, t) {
      print("$t ALL DATA IS");
      print("$e LOGIN AUTH");

      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.genericError,
          title: AppConstant.genericErrorDescription);
    }
  }

  Future<GenericModel> addSatisfactionReview(
      {required String accessToken,
      required int isSatisfied,

      ///if true then add progress satisfaction otherwise add project satisfaction
      bool progressSatisfaction = false,
      required String projectId,
      required String review}) async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $accessToken'};
      String url = '${ENV.baseURL}/api/';
      if (!progressSatisfaction) {
        url = "${url}projects/value/review";
      }
      if (progressSatisfaction) {
        url = "${url}projects/progress/review";
      }
      url = "$url?project_id=$projectId&client_satisfied=$isSatisfied&client_reviews=$review";
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      print(res);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return GenericModel(
            returnedModel: Project.fromJson(jsonDecode(res)['data']),
            success: true,
            title: "Review Added",
            message: "Review Added Successfully",
            statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            title: exceptionModel.errors!.errorList![0].error,
            statusCode: 422,
            message: exceptionModel.errors!.errorList![0].message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: "Invalid Credentials");
      } else if (response.statusCode == 403) {
        return GenericModel(
            returnedModel: null, success: false, statusCode: 403, message: jsonDecode(res)['message'], title: '');
      } else {
        print("sdfsdf");
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: response.statusCode,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    } catch (e) {
      print("$e LOGIN AUTH");
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.genericError,
          title: AppConstant.genericErrorDescription);
    }
  }

  Future<GenericModel> addNewProject(
      {required String accessToken,
      required Project project,
      required List<File> images,
      required List<MediaCompressionModel> media}) async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $accessToken'};
      var request = http.MultipartRequest('POST', Uri.parse('${ENV.baseURL}/api/projects'));
      request.fields.addAll(project.toJson());

      ///UPLOADS PROJECT IMAGES
      if (images != null && images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          request.files.add(await http.MultipartFile.fromPath('photos[$i]', images[i].path));
        }
      }

      ///UPLOAD PROJECT VIDEOS & THEIR THUMBNAILS
      if (media != null && media.isNotEmpty) {
        for (int i = 0; i < media.length; i++) {
          request.files.add(await http.MultipartFile.fromPath('videos[$i][thumbnail]', media[i].thumbnailPath));
          request.files.add(await http.MultipartFile.fromPath('videos[$i][file]', media[i].compressedVideoPath));
        }
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return GenericModel(
            returnedModel: Project.fromJson(jsonDecode(res)['data']),
            success: true,
            title: "Project Created",
            message: "Project Created Successfully",
            statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            title: exceptionModel.errors!.errorList![0].error,
            statusCode: 422,
            message: exceptionModel.errors!.errorList![0].message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: "Invalid Credentials");
      } else {
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: response.statusCode,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    } catch (e) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.genericError,
          title: AppConstant.genericErrorDescription);
    }
  }

  Future<GenericModel> updateProject(
      {required String accessToken,
      required Project project,
      required List<File> images,
      required List<MediaCompressionModel> media}) async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $accessToken'};
      var request = http.MultipartRequest('POST', Uri.parse('${ENV.baseURL}/api/projects?_method=PATCH'));
      request.fields.addAll(project.toJson());

      ///UPLOADS PROJECT IMAGES
      if (images != null && images.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          request.files.add(await http.MultipartFile.fromPath('photos[$i]', images[i].path));
        }
      }

      ///UPLOAD PROJECT VIDEOS & THEIR THUMBNAILS
      if (media != null && media.isNotEmpty) {
        for (int i = 0; i < media.length; i++) {
          request.files.add(await http.MultipartFile.fromPath('videos[$i][thumbnail]', media[i].thumbnailPath));
          request.files.add(await http.MultipartFile.fromPath('videos[$i][file]', media[i].compressedVideoPath));
        }
      }

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      print(res);
      print(response.statusCode);
      if (response.statusCode == 200) {
        return GenericModel(
            returnedModel: Project.fromJson(jsonDecode(res)['data']),
            success: true,
            title: "Project Updated",
            message: "Project Updated Successfully",
            statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            title: exceptionModel.errors!.errorList![0].error,
            statusCode: 422,
            message: exceptionModel.errors!.errorList![0].message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: "Invalid Credentials");
      } else {
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: response.statusCode,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    } catch (e) {
      print("$e LOGIN AUTH");
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.genericError,
          title: AppConstant.genericErrorDescription);
    }
  }

  Future<GenericModel> getAllProjects({required String accessToken, required int page, required fetchAssigned}) async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $accessToken'};
      int getAssigned = 0;
      if (fetchAssigned) {
        getAssigned = 1;
      }
      var request =
          http.Request('GET', Uri.parse('${ENV.baseURL}/api/projects?page=$page&filters[assigned]=$getAssigned'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(returnedModel: ProjectResponse.fromJson(jsonDecode(res)), success: true, statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            message: AppConstant.genericErrorDescription);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: "Invalid Credentials");
      } else {
        return GenericModel(
            returnedModel: null,
            success: false,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_, t) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    }
  }

  Future<GenericModel> searchProject({required String accessToken, required String query}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
        "content-type": "application/x-www-form-urlencoded"
      };
      var request = http.MultipartRequest('POST', Uri.parse('${ENV.baseURL}/api/projects/search'));
      request.headers.addAll(headers);
      request.fields.addAll({'search': query, 'filters[approved]': 'approved'});
      http.StreamedResponse response = await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(
            returnedModel: SearchProjectResponse.fromJson(jsonDecode(res)), success: true, statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            message: AppConstant.genericErrorDescription);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: "Invalid Credentials");
      } else {
        return GenericModel(
            returnedModel: null,
            success: false,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    }
  }

  Future<GenericModel> getAllActivityProjects(
      {required String accessToken, required int page, required String status}) async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $accessToken'};
      var request = http.Request('GET',
          Uri.parse('${ENV.baseURL}/api/projects?page=$page&filters[status]=$status&filters[approved]=approved'));
      request.headers.addAll(headers);
      print("hello" + request.url.toString());
      http.StreamedResponse response = await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(returnedModel: ProjectResponse.fromJson(jsonDecode(res)), success: true, statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            title: exceptionModel.errors!.errorList![0].error,
            message: exceptionModel.message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: AppConstant.sessionTitle);
      } else {
        return GenericModel(
            returnedModel: null,
            success: false,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    } catch (e, t) {
      print(t);
      throw e;
    }
  }

  Future<GenericModel> getAllStatusPending(
      {required String accessToken,
      required int page,
      required bool fetchPending,
      required bool fetchapproved,
      required bool fetchRejected}) async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $accessToken'};
      String url = '${ENV.baseURL}/api/projects?page=$page';
      if (fetchPending) {
        url = "$url&filters[approved]=pending";
      }
      if (fetchapproved) {
        url = "$url&filters[approved]=approved";
      }
      if (fetchRejected) {
        url = "$url&filters[approved]=rejected";
      }
      print("REQ URL $url");
      var request = http.Request('GET', Uri.parse(url));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(returnedModel: ProjectResponse.fromJson(jsonDecode(res)), success: true, statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            title: exceptionModel.errors!.errorList![0].error,
            message: exceptionModel.message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: AppConstant.sessionTitle);
      } else {
        return GenericModel(
            returnedModel: null,
            success: false,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    }
  }

  Future<GenericModel> getProjectById({required String accessToken, required int projectId}) async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

      var request = http.Request('GET', Uri.parse('${ENV.baseURL}/api/projects?filters[byId]=$projectId'));
      request.headers.addAll(headers);
      print(request.body);

      http.StreamedResponse response = await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(returnedModel: Project.fromJson(jsonDecode(res)['data']), success: true, statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            message: AppConstant.genericErrorDescription);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: "Invalid Credentials");
      } else {
        return GenericModel(
            returnedModel: null,
            success: false,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    }
  }


  Future<GenericModel> getProjectGalleryById(
      {required String accessToken, required int projectId}) async {
    try {
      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      var request = http.Request('GET',
          Uri.parse('${ENV.baseURL}/api/project/gallery?filters[byId]=$projectId'));
      request.headers.addAll(headers);
      http.StreamedResponse response =
      await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print('resres $res');
      if (response.statusCode == 200) {
        final parsedModel = await compute((dynamic jsonData) {
          return ProjectMediaGalleryResModel.fromJson(jsonData);
        }, jsonDecode(res));
        return GenericModel(
          returnedModel: parsedModel, success: true, statusCode: 200,
        );
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel =
        ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            message: AppConstant.genericErrorDescription);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: "Invalid Credentials");
      } else {
        return GenericModel(
            returnedModel: null,
            success: false,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    }
  }

  Future<GenericModel> deleteProjectById({required String accessToken, required int projectId}) async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $accessToken'};

      var request = http.Request('POST', Uri.parse('${ENV.baseURL}/api/project/delete?project_id=$projectId'));
      request.headers.addAll(headers);
      print(request.body);

      http.StreamedResponse response = await request.send().timeout(const Duration(seconds: 30));
      var res = await response.stream.bytesToString();
      print(res);
      if (response.statusCode == 200) {
        return GenericModel(returnedModel: Project.fromJson(jsonDecode(res)), success: true, statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(res));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            statusCode: 422,
            message: AppConstant.genericErrorDescription);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: AppConstant.sessionDescription,
            title: "Invalid Credentials");
      } else {
        return GenericModel(
            returnedModel: null,
            success: false,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    }
  }

  Future<GenericModel> projectApproval(
      {required String accessToken, required int projectId, required bool approve}) async {
    try {
      var headers = {'Accept': 'application/json', 'Authorization': 'Bearer $accessToken'};
      String reqUrl = "${ENV.baseURL}/api/projects/approve?project_id=$projectId";
      if (approve) {
        reqUrl = "$reqUrl&approved=approved";
      }
      if (!approve) {
        reqUrl = "$reqUrl&approved=rejected";
      }
      var response = await http.patch(Uri.parse(reqUrl), headers: headers);
      // request.headers.addAll(headers);

      /*http.StreamedResponse response =
          await request.send().timeout(const Duration(minutes: 5));
      var res = await response.stream.bytesToString();*/
      // print(res);
      if (response.statusCode == 200) {
        return GenericModel(
            returnedModel: Project.fromJson(jsonDecode(response.body)['data']),
            title: approve ? "Project Approved" : "Project Rejected",
            message:
                approve ? "Project will be available in New-Activity" : "Project will be available in Rejected List",
            success: true,
            statusCode: 200);
      } else if (response.statusCode == 422) {
        ExceptionModel exceptionModel = ExceptionModel.fromJson(jsonDecode(response.body));
        return GenericModel(
            returnedModel: exceptionModel,
            success: false,
            title: exceptionModel.errors!.errorList![0].error,
            statusCode: 422,
            message: exceptionModel.message);
      } else if (response.statusCode == 401) {
        LogicHelper.unauthorizedHandler();
        return GenericModel(
            returnedModel: null,
            success: false,
            statusCode: 401,
            message: "Please Login again",
            title: "Session Expired");
      } else {
        return GenericModel(
            returnedModel: null,
            success: false,
            message: AppConstant.genericError,
            title: AppConstant.genericErrorDescription);
      }
    } on SocketException {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.networkError,
          title: AppConstant.networkErrorDescritpion);
    } on TimeoutException catch (_) {
      return GenericModel(
          returnedModel: null,
          success: false,
          statusCode: 400,
          message: AppConstant.timeoutError,
          title: AppConstant.timeoutErrorDescription);
    }
  }
}
