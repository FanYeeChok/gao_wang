

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class NetworkWebService {
  var dio = Dio();
  
  //Singleton
  // NetworkWebService._privateConstructor();
  // static final NetworkWebService _instance = NetworkWebService._privateConstructor();
  // static NetworkWebService get instance => _instance;

  //Singleton
  NetworkWebService._privateConstructor();
  static final NetworkWebService _instance = NetworkWebService._privateConstructor();
  factory NetworkWebService() {
    return _instance;
  }

  Future<dynamic> post(String url, dynamic param) async {
    try{
     Response response = await dio.post(url, data: jsonEncode(param),
      options: Options(headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }));

      // print('Response : ${response}');
      return response;
    }on DioError catch(e){
        if (e.response != null) {
          print(e.response.data);
          print(e.response.headers);
          print(e.response.requestOptions);
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          print(e.requestOptions);
          print(e.message);
        }
        throw new Exception(e);
    }
   
  }
  

}