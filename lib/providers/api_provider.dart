import 'package:dio/dio.dart';
import 'dart:async';
import 'package:snaptify/constant/strings.dart';
import 'dart:convert';


class ApiProvider{


  Dio getDio(){
    final token = const String.fromEnvironment('TOKEN', defaultValue: '');
    var options = BaseOptions(
      baseUrl: Strings.base_url,
      headers : {
        'Content-Type' : 'application/json',
        'Token' : token
      }
    );


    Dio dio = Dio(options);

    return dio;
  }

  Future<Response> getSnaptifyByImageUrl(Map<String, String> data) async {
    String _endpoint = "/get_by_image";
    Response response;

    try {
      response = await getDio().post(
        _endpoint,
        data: data
      );
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
    return response;
  }

  Future<Response> getSnaptifyByKeyword(Map<String, String> data) async {
    String _endpoint = "/get_by_keyword";
    Response response;
    try {
      response = await getDio().post(
        _endpoint,
        data: data
      );
    } on Error catch (e) {
      throw Exception('Failed to load post ' + e.toString());
    }
    return response;
  }
}
