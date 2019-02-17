import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:wanandroid/entity/home_article_entity.dart';
import 'package:wanandroid/net/api/ApiRepository.dart';

class HomeArticleViewModel {
  CompositeSubscription _subscription = CompositeSubscription();
  List<HomeArticleEntity> homeArticles;
  StreamController<List<HomeArticleEntity>> _homeArticlesController;

  HomeArticleViewModel() {
    homeArticles = [];
    _homeArticlesController = StreamController<List<HomeArticleEntity>>();
  }

  Stream<List<HomeArticleEntity>> get articles =>
      _homeArticlesController.stream;

  getArticles(int currentPage) async {
    StreamSubscription subscription =
        ApiRepository().getHomeArticle(currentPage).listen((lists) {
      if (lists != null) homeArticles.addAll(lists);
      _homeArticlesController.sink.add(homeArticles);
    });
    _subscription.add(subscription);
  }

  dispose() {
    _homeArticlesController.close();
    _subscription.clear();
  }
}
