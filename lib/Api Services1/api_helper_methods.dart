// Dart imports:
import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// Package imports:
import 'package:fitness/utils/utils.dart';
import 'package:http/http.dart';


// Project imports:

class ApiException implements Exception {
  ApiException(this.errorMessage);

  String errorMessage;

  @override
  String toString() {
    return errorMessage;
  }
}

class ApiBaseHelper {
  Future<dynamic> postAPICall(Uri url, Map param, {String langCode = 'en'}) async {
    log('url-->$url');
    log('parameter-->$param');
    dynamic responseJson;
    try {
      final response = await post(url, body: param.isNotEmpty ? param : [], headers: {
        'Accept-Language' : langCode
      })
              .timeout(const Duration(seconds: 50));
      log('response-->${response.statusCode}');

      responseJson = _response(response);
      // if(responseJson['error']??true && param.keys.isEmpty){
      //   Utils.mySnackBar(title: "Something went wrong",msg: 'please check network and refresh');
      // }
    } on SocketException catch (e) {
      log(e.toString());
      Utils.mySnackBar(
          title: "No Internet", msg: 'Please check your internet connection');
      throw ApiException('No Internet connection');
    } on TimeoutException {
      Utils.mySnackBar(title: "Time Out", msg: "Please try again");
      throw ApiException('Something went wrong, Server not Responding');
    }   on Exception catch (e) {
     // Utils.mySnackBar(title: "Error Found", msg: e.toString());
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }

  Future<dynamic> postMultipartAPICall(Uri url, Map<String, String> fields,
      {List<File>? files, String? fileKey}) async {
    dynamic responseJson;
    log('url-->$url');
    log('fields-->$fields');
    log('files-->$files');

    try {
      var request = MultipartRequest('POST', url);

      // Add fields to the request
      request.fields.addAll(fields);
      if (files != null) {
        for (var file in files) {
          request.files.add(await MultipartFile.fromPath(fileKey!, file.path));
        }
      }
      request.headers.addAll(headers);
      // Send the request
      var response = await request.send();
      log('response $response');
      log('files-->${request.files}');
      // Read the response
      var responseString = await response.stream.bytesToString();
      log('response $responseString');
      responseJson = _response(Response(responseString, response.statusCode));
    } on SocketException catch (e) {
      log(e.toString());
      Utils.mySnackBar(
          title: "Error Found",
          msg: 'No Internet Connection, Please check your internet connection');
      throw ApiException('No Internet connection');
    } on TimeoutException {
      Utils.mySnackBar(title: "Time Out", msg: "Please try again");
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      Utils.mySnackBar(title: "Error Found", msg: e.toString());
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }

  Future<dynamic> getAPICall(Uri url,{String langCode = 'en'}) async {
    dynamic responseJson;
    log('url-->$url');
    try {
      final response =
          await get(url, headers: {'Accept-Language':langCode}).timeout(const Duration(seconds: 50));
      log('status code ${response.statusCode}');
      responseJson = _response(response);
      /*if(responseJson['error']??true){
        Utils.mySnackBar(title: "Something went wrong",msg: 'please check network and refresh');
      }*/
    } on SocketException catch (e) {
      log(e.toString());
      Utils.mySnackBar(
          title: "Error Found",
          msg: 'No Internet Connection, Please check your internet connection');
      throw ApiException('No Internet connection');
    } on TimeoutException {
      Utils.mySnackBar(title: "Time Out", msg: "Please try again");
      throw ApiException('Something went wrong, Server not Responding');
    } on Exception catch (e) {
      Utils.mySnackBar(title: "Error Found", msg: e.toString());
      throw ApiException('Something Went wrong with ${e.toString()}');
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        Utils.mySnackBar(msg: json.decode(response.body)['message']);
        throw BadRequestException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode: ${response.statusCode}');
    }
  }
}

class CustomException implements Exception {
  final String message;
  final String prefix;

  CustomException([this.message = "", this.prefix = '']);

  @override
  String toString() {
    return "$prefix$message";
  }
}

class FetchDataException extends CustomException {
  FetchDataException([message])
      : super(message, 'Error During Communication: ');
}

class BadRequestException extends CustomException {
  BadRequestException([message]) : super(message, 'Invalid Request: ');
}

class UnauthorisedException extends CustomException {
  UnauthorisedException([message]) : super(message, 'Unauthorised: ');
}

class InvalidInputException extends CustomException {
  InvalidInputException([message]) : super(message, 'Invalid Input: ');
}

Map<String, String> get headers => {
      'Cookie': 'ci_session=3a2ad9ed3b163b1b2873213952605317b83816b3',

    };
