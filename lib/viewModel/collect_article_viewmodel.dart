import 'dart:async';
import 'base_viewmodel.dart';
import 'package:wanandroid/entity/home_article_entity.dart';


class CollectArticleViewModel extends BaseViewModel {

  List<HomeArticleEntity> _collectList;
  StreamController<List<HomeArticleEntity>> _controller;

  Stream<List<HomeArticleEntity>> get collectController => _controller.stream;

  CollectArticleViewModel() {
    _collectList = new List();
    _controller = new StreamController();
  }


  //收藏文章
  doCollect(int articleId, successCallback, errorCallback) {
    subscription = repository.doCollect(articleId)
        .listen((value) {
      if (value) {
        successCallback();
      } else {
        errorCallback();
      }
    });
    subscriptions.add(subscription);
  }

  //取消收藏
  unCollect(int articleId, int originId, successCallback, errorCallback) {
    subscription = repository.unCollect(articleId, originId)
        .listen((value) {
      if (value) {
        successCallback();
      } else {
        errorCallback();
      }
    });
    subscriptions.add(subscription);
  }

  //获取收藏列表
  getCollectList(int currentPage) {
    subscription = repository.getCollectionArticle(currentPage)
        .listen((value) {
      if (value != null) {
        _collectList.addAll(value);
      }
      _controller.sink.add(_collectList);
    });
    subscriptions.add(subscription);
  }

  void clearList(){
    _collectList.clear();
  }

  @override
  dispose() {
    _collectList.clear();
    return super.dispose();
  }
}