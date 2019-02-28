import 'package:dio/dio.dart';
import 'package:wanandroid/net/log/DioLogger.dart';
import 'package:sprintf/sprintf.dart';
import 'package:wanandroid/model/home_article.dart';
import 'package:wanandroid/model/find_response.dart';
import 'package:wanandroid/model/banner_response.dart';
import 'package:wanandroid/model/groom_response.dart';
import 'package:wanandroid/model/user_response.dart';
import 'package:wanandroid/util/utils.dart';
import 'package:wanandroid/res/constant.dart';


class ApiProvider {
  static const String _baseUrl = "http://www.wanandroid.com";
  static const String _homeArticleUrl = "/article/list/%d/json";
  static const String _homeFindUrl = "/tree/json";
  static const String _findDetailUrl = "/article/list/%d/json?cid=";
  static const String _bannerUrl = "/banner/json";
  static const String _groomUrl = "/hotkey/json";
  static const String _searchUrl = "/article/query/%d/json";
  static const String _loginUrl = "/user/login";
  static const String _registerUrl = "/user/register";
  static const String _logoutUrl = "/user/logout/json";
  static const String TAG = "dio========";
  static const String _cookie_tag = "set-cookie";

  Dio _dio;

  ApiProvider() {
    Options options = new Options(
      baseUrl: _baseUrl,
    );

    _dio = Dio(options);

    DioLogger dioLogger = new DioLogger();

    _dio.interceptor.request.onSend = (Options options) {
      dioLogger.onSend(TAG, options);
      return options;
    };

    _dio.interceptor.response.onSuccess = (Response response) {
      dioLogger.onSuccess(TAG, response);
      return response;
    };

    _dio.interceptor.response.onError = (DioError error) {
      dioLogger.onError(TAG, error);
      return error;
    };
  }


  //获取首页文章
  getHomeArticle(int currentPage) async {
    var response =
    await _dio.get(sprintf(_homeArticleUrl, [currentPage]));
    HomeArticle article = HomeArticle.fromJson(response.data);
    return article;
  }

  //获取首页发现页面
  getHomeFind() async {
    var response = await _dio.get(_homeFindUrl);
    FindResponse findResponse = FindResponse.fromJson(response.data);
    return findResponse;
  }

  //获取发现页面详情文章列表
  getFindDetailArticle(int currentPage, String cid) async {
    var response = await _dio.get(sprintf(_findDetailUrl,
        [currentPage]) + cid);
    HomeArticle article = HomeArticle.fromJson(response.data);
    return article;
  }

  //获取轮播图
  getBanner() async {
    var response = await _dio.get(_bannerUrl);
    BannerResponse banner = BannerResponse.fromJson(response.data);
    return banner;
  }

  //获取推荐列表
  getGroom() async {
    var response = await _dio.get(_groomUrl);
    GroomResponse groomResponse = GroomResponse.fromJson(response.data);
    return groomResponse;
  }

  //获取搜索结果
  getSearchArticle(int currentPage, String keywords) async {
    FormData data = new FormData();
    data.add("k", keywords);
    var response = await _dio.post(
        sprintf(_searchUrl, [currentPage]), data: data);
    HomeArticle article = HomeArticle.fromJson(response.data);
    return article;
  }

  //登录接口
  doLogin(String userName, String password) async {
    FormData data = new FormData();
    data.add("username", userName);
    data.add("password", password);
    var response = await _dio.post(_loginUrl, data: data);
    List<String> cookie = response.headers[_cookie_tag];
    if (cookie != null && cookie.length > 0) {
      Utils.save(Strings.login_cookie, cookie);
    }

    UserResponse userResponse = UserResponse.fromJson(response.data);
    return userResponse;
  }

  Future<bool> doLogout() async {
    var response = await _dio.get(_logoutUrl);
    bool result;
    if (response.statusCode == 200) {
      result = true;
    }else{
      result = false;
    }
    return result;
  }
  
  doRegister(String userName,String password) async{
    FormData data = new FormData();
    data.add("username", userName);
    data.add("password", password);
    data.add("repassword", password);
    var response = await _dio.post(_registerUrl, data: data);
    UserResponse userResponse = UserResponse.fromJson(response.data);
    return userResponse;
  }
}
