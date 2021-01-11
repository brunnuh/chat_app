import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class Api{
  String url = "http://648029e81239.ngrok.io/api/";
  Dio _dio = Dio();


/*
  Future login(String email, String password) async {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =(HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try{
      Map map = {
        "email" : email,
        "password" : password
      };
      Response response = await _dio.post(url + "login", data: map);
      if(response.statusCode == 200){
        return response.data;
      }
      return "erro";
    }on DioError catch(e){
      print(e.response);
      return "erro";
    }
  }*/

  Future<void> sendMessage(String content, String id) async {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =(HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try{
      Map map = {
        "content" : content,
        "id" : id
      };
      //_dio.options.headers["Authorization"] = "Bearer" + token;
      Response response = await _dio.post(url + "messages", data: map);
      if(response.statusCode == 200){
        return response.data["access_token"];
      }
      return "erro";
    }on DioError catch(e){
      print(e.response);
      return "erro";
    }
  }
/*
  Future me(String token) async {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =(HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
    try{

      _dio.options.headers["Authorization"] = "Bearer " + token;
      Response response = await _dio.post(url + "me");
      if(response.statusCode == 200){
        return response.data;
      }
      return "erro";
    }on DioError catch(e){
      print(e);
      return "erro";
    }
  }
*/
}