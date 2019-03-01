import 'package:rxdart/rxdart.dart';
import 'package:wanandroid/entity/home_article_entity.dart';
import 'package:wanandroid/model/home_article.dart';
import 'package:wanandroid/model/find_response.dart';
import 'package:wanandroid/entity/find_entity.dart';
import 'package:wanandroid/entity/banner_entity.dart';
import 'package:wanandroid/model/banner_response.dart';
import 'package:wanandroid/entity/home_page_entity.dart';
import 'package:wanandroid/entity/hot_key_entity.dart';
import 'package:wanandroid/model/groom_response.dart';
import 'package:wanandroid/entity/login_entity.dart';
import 'package:wanandroid/model/user_response.dart';
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

  // 首页banner
  Observable<List<BannerEntity>> getBanner() {
    return Observable.fromFuture(
        _apiProvider.getBanner()
    ).flatMap(_bannerToEntity);
  }

  //整合的首页数据---暂未使用
  Observable<HomePageEntity> getHomeDates(int currentPage) {
    return Observable.zip2(getBanner(), getHomeArticle(currentPage),
            (one, two) {
          HomePageEntity entity = new HomePageEntity();
          entity.banners = one;
          entity.articles = two;
          return entity;
        });
  }

  //发现页面
  Observable<List<FindEntity>> _findToEntity(finds) {
    List<FindEntity> list = [];
    if (finds == null) {} else {
      if (finds is FindResponse) {
        for (var _find in finds.data) {
          FindEntity entity = new FindEntity();
          entity.channelId = _find.id.toString();
          entity.channelName = _find.name;
          entity.children = _childrenToEntity(_find.children);
          list.add(entity);
        }
      }
    }
    return Observable.just(list);
  }

  //获取搜索热词
  Observable<List<HotKeyEntity>> getHotKey() {
    return Observable.fromFuture(_apiProvider.getGroom())
        .flatMap(_hotKeyToEntity);
  }

  //获取搜索结果
  Observable<List<HomeArticleEntity>> getSearchResult(int currentPage,
      String keywords) {
    return Observable.fromFuture(
        _apiProvider.getSearchArticle(currentPage, keywords))
        .flatMap(_articleToEntity);
  }

  //用户登录
  Observable<UserEntity> doLogin(String userName, String password) {
    return Observable.fromFuture(_apiProvider.doLogin(userName, password))
        .flatMap(_loginToEntity);
  }

  //退出登录
  Observable<bool> doLogout() {
    return Observable.fromFuture(_apiProvider.doLogout());
  }

  //用户注册
  Observable<dynamic> doRegister(String userName, String password) {
    return Observable.fromFuture(_apiProvider.doRegister(userName, password))
        .flatMap(_registerToEntity);
  }

  //获取收藏的列表集合
  Observable<List<HomeArticleEntity>> getCollectionArticle(int currentPage) {
    return Observable.fromFuture(
        _apiProvider.getCollectList(currentPage))
        .flatMap(_articleToEntity);
  }

  //收藏文章
  Observable<bool> doCollect(int articleId) {
    return Observable.fromFuture(_apiProvider.doCollect(articleId));
  }

  Observable<bool> unCollect(int articleId, int originId) {
    return Observable.fromFuture(
        _apiProvider.unCollectArticle(articleId, originId));
  }

  _childrenToEntity(List<Children> findChildren) {
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

    } else if (article is HomeArticle && article.data != null) {
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
        entity.id = _.id;
        entity.originId = _.originId;
        lists.add(entity);
      }
    }
    return Observable.just(lists);
  }

  Observable<List<BannerEntity>> _bannerToEntity(banner) {
    List<BannerEntity> banners = new List();
    if (banner == null) {

    } else if (banner is BannerResponse && banner.data != null) {
      for (var item in banner.data) {
        BannerEntity entity = new BannerEntity();
        entity.articleUrl = item.url;
        entity.title = item.title;
        entity.imgUrl = item.imagePath;
        banners.add(entity);
      }
    }
    return Observable.just(banners);
  }

  Observable<List<HotKeyEntity>> _hotKeyToEntity(value) {
    List<HotKeyEntity> list = new List();
    if (value != null && value is GroomResponse && value.data != null) {
      for (var item in value.data) {
        HotKeyEntity entity = new HotKeyEntity();
        entity.name = item.name;
        entity.id = item.id;
        list.add(entity);
      }
    }
    return Observable.just(list);
  }

  Observable<UserEntity> _loginToEntity(value) {
    UserEntity entity = new UserEntity();
    if (value != null && value is UserResponse && value.data != null) {
      entity.id = value.data.id;
      entity.token = value.data.token;
      entity.username = value.data.username;
    }
    return Observable.just(entity);
  }

  Observable<dynamic> _registerToEntity(value) {
    UserEntity entity = new UserEntity();
    if (value != null && value is UserResponse) {
      if (value.data != null) {
        entity.id = value.data.id;
        entity.token = value.data.token;
        entity.username = value.data.username;
        return Observable.just(entity);
      } else {
        return Observable.just(value.errorMsg);
      }
    }
  }

}
