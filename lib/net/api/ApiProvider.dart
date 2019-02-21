import 'package:dio/dio.dart';
import 'package:sprintf/sprintf.dart';
import 'package:wanandroid/model/home_article.dart';
import 'package:wanandroid/model/find_response.dart';
import 'package:wanandroid/model/banner_response.dart';

class ApiProvider {
  static const String _BASE_URL = "http://www.wanandroid.com";
  static const String _HOME_ARTICLE_URL = "/article/list/%d/json";
  static const String _HOME_FIND_URL = "/tree/json";
  static const String _FIND_DETAIL_URL = "/article/list/%d/json?cid=";
  static const String _BANNER_URL = "/banner/json";

  static Options options = new Options(
      baseUrl: _BASE_URL
  );

  Dio _dio = Dio(options);

  //获取首页文章
  getHomeArticle(int currentPage) async {
    var response =
    await _dio.get(sprintf(_HOME_ARTICLE_URL, [currentPage]));
    HomeArticle article = HomeArticle.fromJson(response.data);
    return article;
  }

  //获取首页发现页面
  getHomeFind() async {
    var response = await _dio.get(_HOME_FIND_URL);
    FindResponse findResponse = FindResponse.fromJson(response.data);
    return findResponse;
  }

  //获取发现页面详情文章列表
  getFindDetailArticle(int currentPage, String cid) async {
    var response = await _dio.get(sprintf(_FIND_DETAIL_URL,
        [currentPage]) + cid);
    HomeArticle article = HomeArticle.fromJson(response.data);
    return article;
  }

  getBanner() async {
    var response = await _dio.get(_BANNER_URL);
    BannerResponse banner = BannerResponse.fromJson(response.data);
    return banner;
  }
}
