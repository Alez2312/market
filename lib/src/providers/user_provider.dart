import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:market/src/utils/shared_pref.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:market/src/api/environment.dart';
import 'package:market/src/models/response_api.dart';
import 'package:market/src/models/user.dart';
import 'package:http/http.dart' as http;

class UserProvider {
  final String _url = Environment.API_MARKET;
  final String _api = '/api/users';

  BuildContext? context;
  User? sessionUser;

  Future? init(BuildContext context, {User? sessionUser}) {
    this.context = context;
    this.sessionUser = sessionUser;
    return null;
  }

  Future<User?> findByUserId(String id) async {
    try {
      Uri url = Uri.http(_url, '$_api/findByUserId/$id');
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': '${(sessionUser!.sessionToken!)}'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Tu sesión expiró');
        SharedPref().logout(context!, sessionUser!.id!);
      }
      final data = json.decode(response.body);
      User user = User.fromJson(data);
      return user;
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  Future<Stream?> createWithImage(User user, File image) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      final request = http.MultipartRequest('POST', url);
      if (image != null) {
        request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(image.openRead().cast()),
          await image.length(),
          filename: basename(image.path),
        ));
      }
      // ['user'] debe ser igual a la const del método registerWithImage de userController del servidor
      request.fields['user'] = json.encode(user);
      final response = await request.send();
      return response.stream.transform(utf8.decoder);
    } catch (error) {
      print('Error: ${error}');
      return null;
    }
  }

  Future<Stream?> update(User user, File? image) async {
    try {
      Uri url = Uri.http(_url, '$_api/update');
      final request = http.MultipartRequest('PUT', url);
      request.headers['Authorization'] = sessionUser!.sessionToken!;
      if (image != null) {
        request.files.add(http.MultipartFile(
          'image',
          http.ByteStream(image.openRead().cast()),
          await image.length(),
          filename: basename(image.path),
        ));
      }
      // ['user'] debe ser igual a la const del método registerWithImage de userController del servidor
      request.fields['user'] = json.encode(user);
      final response = await request.send();
      if (response.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Tu sesión expiro');
        SharedPref().logout(context!, sessionUser!.id!);
      }
      return response.stream.transform(utf8.decoder);
    } catch (error) {
      print('Error: ${error}');
      return null;
    }
  }

  Future<ResponseApi> create(User user) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(user);
      Map<String, String> headers = {'Content-type': 'application/json'};
      final response = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(response.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (error) {
      print('Error: $error');
      return ResponseApi(success: false, message: 'An error occurred: $error');
    }
  }

  Future<ResponseApi> logout(String idUser) async {
    try {
      Uri url = Uri.http(_url, '$_api/logout');
      String bodyParams = json.encode({'id': idUser});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final response = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(response.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (error) {
      print('Error: $error');
      return ResponseApi(success: false, message: 'An error occurred: $error');
    }
  }

  Future<ResponseApi> login(String email, String password) async {
    try {
      Uri url = Uri.http(_url, '$_api/login');
      String bodyParams = json.encode({'email': email, 'password': password});
      Map<String, String> headers = {'Content-type': 'application/json'};
      final response = await http.post(url, headers: headers, body: bodyParams);
      final data = json.decode(response.body);
      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (error) {
      print('Error: $error');
      return ResponseApi(success: false, message: 'An error occurred: $error');
    }
  }
}
