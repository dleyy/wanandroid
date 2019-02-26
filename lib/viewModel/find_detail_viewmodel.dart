import 'dart:async';
import 'package:wanandroid/entity/home_article_entity.dart';
import 'package:wanandroid/viewModel/base_viewmodel.dart';

class FindDetailViewModel extends BaseViewModel {

  List<HomeArticleEntity> _detailArticles;
  StreamController<List<HomeArticleEntity>> _detailArticleController;

  FindDetailViewModel() {
    _detailArticles = [];
    _detailArticleController = new StreamController<List<HomeArticleEntity>>();
  }

  Stream<List<HomeArticleEntity>> get articles =>
      _detailArticleController.stream;

  getArticles(int currentPage, String cid) async {
    subscription =
        repository.getFindDetailArticle(currentPage, cid).listen((lists) {
          if (lists != null) _detailArticles.addAll(lists);
          _detailArticleController.sink.add(_detailArticles);
        });
    subscriptions.add(subscription);
  }

  //清除列表
  cleanList() {
    _detailArticles.clear();
  }

  @override
  dispose() {
    _detailArticles.clear();
    super.dispose();
  }
}
