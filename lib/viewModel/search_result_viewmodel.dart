import 'base_viewmodel.dart';
import 'dart:async';
import 'package:wanandroid/entity/home_article_entity.dart';

class SearchResultViewModel extends BaseViewModel {

  StreamController<List<HomeArticleEntity>> _streamController;
  List<HomeArticleEntity> _list;

  Stream<List<HomeArticleEntity>> get articleStream =>
      _streamController.stream;

  SearchResultViewModel() {
    _streamController = new StreamController();
    _list = new List();
  }


  getSearchResult(int currentPage, String keywords) {
    subscription = repository.getSearchResult(currentPage, keywords)
        .listen((res) {
      _list.addAll(res);
      _streamController.sink.add(_list);
    });

    subscriptions.add(subscription);
  }

  @override
  dispose() {
    _streamController.close();
    return super.dispose();
  }

  clearData() {
    _list.clear();
  }
}