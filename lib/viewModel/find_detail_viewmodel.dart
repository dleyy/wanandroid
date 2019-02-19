import 'dart:async';

import 'package:wanandroid/entity/home_article_entity.dart';
import 'package:wanandroid/net/api/ApiRepository.dart';
import 'package:wanandroid/viewModel/base_viewmodel.dart';

class FindDetailViewModel extends BaseViewModel {

  List<HomeArticleEntity> _homeArticles;
  StreamController<List<HomeArticleEntity>> _homeArticlesController;

  HomeArticleViewModel() {
    _homeArticles = [];
    _homeArticlesController = StreamController<List<HomeArticleEntity>>();
  }

  Stream<List<HomeArticleEntity>> get articles =>
      _homeArticlesController.stream;

  getArticles(int currentPage, String cid) async {
    StreamSubscription subscription =
    ApiRepository().getFindDetailArticle(currentPage, cid).listen((lists) {
      if (lists != null) _homeArticles.addAll(lists);
      _homeArticlesController.sink.add(_homeArticles);
    });
    subscriptions.add(subscription);
  }

  //清除列表
  cleanList() {
    _homeArticles.clear();
  }

  @override
  dispose() {
    _homeArticles.clear();
    super.dispose();
  }
}
