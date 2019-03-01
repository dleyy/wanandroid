import 'package:flutter/material.dart';
import 'package:wanandroid/widget/recycle_view.dart';
import 'package:wanandroid/entity/home_article_entity.dart';
import 'package:wanandroid/res/constant.dart';
import 'article_detail.dart';
import 'package:wanandroid/viewModel/collect_article_viewmodel.dart';

//共有的 article 列表 widget
// ignore: must_be_immutable
class CommonArticleList extends StatefulWidget {

  List<HomeArticleEntity> _list = new List();
  Function loadData;
  Function clearData;
  bool showLoading;

  CommonArticleList(this._list, this.loadData,
      this.clearData,[this.showLoading = true]);

  @override
  State<StatefulWidget> createState() => new _ArticleState();

}

class _ArticleState extends State<CommonArticleList>
    with AutomaticKeepAliveClientMixin {

  List<HomeArticleEntity> _list;
  static int _start_page = 0;
  int _currentPage = _start_page;
  CollectArticleViewModel _viewModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _list = widget._list;
    _viewModel = new CollectArticleViewModel();
    super.initState();
  }

  @override
  void didUpdateWidget(CommonArticleList oldWidget) {
    _list = widget._list;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if (_list.length == 0&&!widget.showLoading) {
      return new Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text("暂无数据~")
          ],
        ),
      );
    } else {
      return RecycleView<HomeArticleEntity>(
        lists: _list,
        loadMore: () {
          _loadData(++_currentPage);
        },
        refresh: () {
          _currentPage = _start_page;
          _loadData(_currentPage);
        },
        itemCount: _list.length,
        listBuilder: _createBuilder,
      );
    }
  }

  Widget _createBuilder(BuildContext context, int index) {
    HomeArticleEntity article = _list[index];
    return GestureDetector(
        onTap: () => _itemClicked(index),
        child: Card(
          elevation: Values.card_elevation,
          child: Container(
              child: Container(
                padding: EdgeInsets.only(left: Values.horizontal_padding,
                    right: Values.horizontal_padding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(6.0),
                            ),
                            Text(
                              article.articleTitle,
                              softWrap: true,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Values.title_font_size),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                new Expanded(
                                  child: RichText(
                                      text: TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: "作者:  ",
                                              style:
                                              DefaultTextStyle
                                                  .of(context)
                                                  .style),
                                          TextSpan(
                                              text: article.author,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15.0))
                                        ],
                                      )),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "发布时间:  ",
                                    style: DefaultTextStyle
                                        .of(context)
                                        .style,
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: article.times,
                                          style: TextStyle(
                                              color: Colors.black))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Padding(padding: EdgeInsets.all(5.0))
                          ],
                        )),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.favorite_border),
                        color: (article.collect == null || article.collect)
                            ? Colors.red
                            : Colors.black,
                        onPressed: () => _collect(article.courseId, index),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }

  _collect(int courseId, int index) {
    int articleId = _list[index].id;
    int originId = _list[index].originId;
    if (_list[index].collect == null) {
      _unCollect(articleId, originId, index);
    } else {
      if (!_list[index].collect) {
        _doCollect(articleId, index);
      } else {
        print("has collected");
      }
    }
  }

  _unCollect(int articleId, int originId, index) {
    _viewModel.unCollect(articleId, originId,
            () {
          setState(() {
            _list.removeAt(index);
          });
        }, () {
          print("error");
        });
  }

  _doCollect(int articleId, int index) {
    _viewModel.doCollect(articleId, () {
      setState(() {
        _list[index].collect = true;
      });
    }, () {});
  }

  _itemClicked(int index) {
    String title = _list[index].articleTitle;
    var urls = _list[index].link;
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
          return ArticleDetail(
            detailUrl: urls,
            articleTitle: title,
          );
        }));
  }

  _loadData(int currentPage) async {
    if (currentPage == _start_page && _list.isNotEmpty) {
      widget.clearData();
    }
    await widget.loadData(currentPage);
  }

}

