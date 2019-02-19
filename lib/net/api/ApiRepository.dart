import 'package:rxdart/rxdart.dart';
import 'package:wanandroid/entity/home_article_entity.dart';
import 'package:wanandroid/model/home_article.dart';
import 'package:wanandroid/model/find_response.dart';
import 'package:wanandroid/entity/find_entity.dart';
import 'ApiProvider.dart';

class ApiRepository {
  ApiProvider _apiProvider;

  ApiRepository() {
    _apiProvider = ApiProvider();
  }

  //首页文章
  Observable<List<HomeArticleEntity>> getHomeArticle(int currentPage) {
    return Observable.fromFuture(_apiProvider.getHomeArticle(currentPage))
        .flatMap(_articleToEntity);
  }

  // 首页发现
  Observable<List<FindEntity>> getHomeFind() {
    return Observable.fromFuture(_apiProvider.getHomeFind())
        .flatMap(_findToEntity);
  }

  // 发现二级栏目列表
  Observable<List<HomeArticleEntity>> getFindDetailArticle(int currentPage,
      String cid) {
    return Observable.fromFuture(
        _apiProvider.getFindDetailArticle(currentPage, cid))
        .flatMap(_articleToEntity);
  }

  Observable<List<FindEntity>> _findToEntity(finds) {
    List<FindEntity> list = [];
    if (finds == null) {
      return Observable.just(list);
    } else {
      if (finds is FindResponse) {
        for (var _find in finds.data) {
          FindEntity entity = new FindEntity();
          entity.channelId = _find.id.toString();
          entity.channelName = _find.name;
          entity.children = childrenToEntity(_find.children);
          list.add(entity);
        }
        return Observable.just(list);
      }
    }
  }

  childrenToEntity(List<Children> findChildren) {
    List<FindEntity> children = [];
    for (var child in findChildren) {
      FindEntity entity = new FindEntity();
      entity.channelName = child.name;
      entity.channelId = child.id.toString();
      children.add(entity);
    }
    return children;
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
