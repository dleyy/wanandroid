import 'package:dio/dio.dart';
import 'Log.dart';
import 'package:wanandroid/util/utils.dart';
import 'package:wanandroid/res/constant.dart';

class DioLogger{

  DioLogger(){
    Log.init();
  }

  onSend(String tag, Options options)async{
    Map<String,dynamic> headers = new Map();
    headers['Cookie'] = await Utils.get(Strings.login_cookie);
    options.headers = headers;
    Log.info('$tag - Request Path : [${options.method}] ${options.baseUrl}${options.path}');
  }

  onSuccess(String tag, Response response){
    Log.info('$tag - Response Path : [${response.request.method}] ${response.request.baseUrl}${response.request.path} Request Data : ${response.request.data.toString()}');
  }

  onError(String tag, DioError error){
    Log.info('$tag - Response data : ${error.response.data.toString()}');
  }
}