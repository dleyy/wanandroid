import 'package:dio/dio.dart';

import 'urls.dart';

class NetUtil {
  static const String GET = "get";
  static const String POST = "post";

  static Future get(String url, Function callBack,
      {dynamic params, Function errorCallBack}) async {
    return _request(Urls.baseUrl + url, callBack,
        method: GET, params: params, errorCallBack: errorCallBack);
  }

  static Future post(String url, Function callBack,
      [dynamic params, Function errorCallBack]) async {
    return _request(Urls.baseUrl + url, callBack,
        method: POST, params: params, errorCallBack: errorCallBack);
  }

  //公共代码部分具体的还是要看返回数据的基本结构
  static Future _request(String url, Function callBack,
      {String method, dynamic params, Function errorCallBack}) async {
    print("<http> url :<" + method + ">" + url);

    if (params != null && params.isNotEmpty) {
      print("<http> params :" + params.toString());
    }

    int statusCode;

    Response response;
    try {
      if (method == GET) {
        //组合GET请求的参数
        if (params != null && params is Map && params.isNotEmpty) {
          StringBuffer sb = new StringBuffer("?");
          params.forEach((key, value) {
            sb.write("$key" + "=" + "$value" + "&");
          });
          String paramStr = sb.toString();
          paramStr = paramStr.substring(0, paramStr.length - 1);
          url += paramStr;
        }
        response = await Dio().get(url);
      } else {
        if (params != null && params.isNotEmpty) {
          response = await Dio().post(url, data: params);
        } else {
          response = await Dio().post(url);
        }
      }
    } catch (exception) {
      _handError(errorCallBack, statusCode);
      return Future.value();
    }

    statusCode = response.statusCode;
    var result = response.data;

    //处理错误部分
    if (statusCode != 200) {
      _handError(errorCallBack, statusCode);
    }

    if (callBack != null) {
      callBack(result);
      print("<http> response data:" + result.toString());
    }
  }

  //处理异常
  static void _handError(Function errorCallback, int statusCode) {
    print("<http> statusCode :$statusCode");
    errorCallback("网络连接失败");
  }
}
