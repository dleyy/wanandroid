import 'package:rxdart/rxdart.dart';
import 'package:wanandroid/entity/home_article_entity.dart';
import 'package:wanandroid/model/home_article.dart';

import 'ApiProvider.dart';

class ApiRepository {
  ApiProvider _apiProvider;

  ApiRepository() {
    _apiProvider = ApiProvider();
  }

  Observable<List<HomeArticleEntity>> getHomeArticle(int currentPage) {
    return Observable.fromFuture(_apiProvider.getHomeArticle(currentPage))
        .flatMap(_articleToEntity);
  }

  Observable<List<HomeArticleEntity>> _articleToEntity(article) {
    List<HomeArticleEntity> lists = [];
    if (article == null) {
      return Observable.just(lists);
    } else if (article is HomeArticle) {
      for (var _ in article.data.datas) {
        HomeArticleEntity entity = new HomeArticleEntity();
        entity.courseId = _.courseId;
        entity.collect = _.collect;
        entity.times = DateTime.fromMicrosecondsSinceEpoch(_.publishTime * 1000)
            .toString()
            .split(' ')[0];
        entity.author = _.author;
        entity.articleTitle = _.title.trim().toString();
        entity.link = _.link;
        lists.add(entity);
      }
      return Observable.just(lists);
    }

    return Observable.just(null);
  }
}
