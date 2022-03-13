import 'package:snaptify/models/snaptify_response_model.dart';
import 'package:snaptify/providers/response_data.dart';
import 'package:snaptify/providers/api_provider.dart';
import 'package:dio/dio.dart';
import 'dart:async';

class MainRepository{
  ApiProvider _apiProvider = ApiProvider();

  Future<ResponseData> getSnaptifyByImageUrl(Map<String, String> data) async{
  	Response response = await _apiProvider.getSnaptifyByImageUrl(data);
  	SnaptifyResponseModel responseJust = SnaptifyResponseModel.fromJson(response.data);
  	if (responseJust == null) {
      return ResponseData.connectivityError();
    }

    if (response.statusCode == 200) {
      return ResponseData.success(responseJust);
    } else {
      return ResponseData.error("Error");
    }
  }

  Future<ResponseData> getSnaptifyByKeyword(Map<String, String> data) async{
    Response response = await _apiProvider.getSnaptifyByKeyword(data);
    SnaptifyResponseModel responseJust = SnaptifyResponseModel.fromJson(response.data);
    if (responseJust == null) {
      return ResponseData.connectivityError();
    }

    if (response.statusCode == 200) {
      return ResponseData.success(responseJust);
    } else {
      return ResponseData.error("Error");
    }
  }
}