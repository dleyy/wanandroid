import 'package:dio/dio.dart';
import 'Log.dart';

class DioLogger{

  DioLogger(){
    Log.init();
  }

  onSend(String tag, Options options){
    Log.info('$tag - Request Path : [${options.method}] ${options.baseUrl}${options.path}');
    Log.info('$tag - Request Data : ${options.data.toString()}');
  }

  onSuccess(String tag, Response response){
    Log.info('$tag - Response Path : [${response.request.method}] ${response.request.baseUrl}${response.request.path} Request Data : ${response.request.data.toString()}');
    Log.info('$tag - Response statusCode : ${response.statusCode}');
    Log.info('$tag - Response data : ${response.data.toString()}');
  }

  onError(String tag, DioError error){
    Log.info('$tag - Response Path : [${error.response.request.method}] ${error.response.request.baseUrl}${error.response.request.path} Request Data : ${error.response.request.data.toString()}');
    Log.info('$tag - Response statusCode : ${error.response.statusCode}');
    Log.info('$tag - Response data : ${error.response.data.toString()}');
  }
}