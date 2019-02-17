import 'package:dio/dio.dart';
import 'package:sprintf/sprintf.dart';
import 'package:wanandroid/model/home_article.dart';

class ApiProvider {
  static const String _BASE_URL = "http://www.wanandroid.com";
  static const String _HOME_ARTICLE_URL = "/article/list/%d/json";
  Dio _dio = Dio();

  getHomeArticle(int currentPage) async {
    var response =
        await _dio.get(_BASE_URL + sprintf(_HOME_ARTICLE_URL, [currentPage]));
    HomeArticle article = HomeArticle.fromJson(response.data);
    return article;
  }
}
