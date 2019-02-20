import 'package:flutter/material.dart';
import 'package:wanandroid/entity/find_entity.dart';
import 'package:wanandroid/viewModel/find_detail_viewmodel.dart';
import 'package:wanandroid/widget/recycle_view.dart';
import 'package:wanandroid/entity/home_article_entity.dart';
import 'package:wanandroid/res/constant.dart';
import 'package:wanandroid/view/article_detail.dart';


class FindList extends StatefulWidget {

  String title;
  String id;
  List<FindEntity> content;

  FindList(@required this.title, @required this.id, @required this.content);

  @override
  State<StatefulWidget> createState() => _DetailList();

}

class _DetailList extends State<FindList> with
    SingleTickerProviderStateMixin{
  TabController _controller;
  var _tabs = <Widget>[];
  var _tabView = <Widget>[];

  @override
  void initState() {
    _controller = new TabController(length: widget.content.length,
        vsync: this);
    for (int i = 0; i < widget.content.length; i++) {
      _tabs.add(new Tab(text: widget.content[i].channelName,));
      _tabView.add(_FindRecycle(widget.content[i].channelId));
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("tabs.length===${_tabs.length}");
    return new Scaffold(
      appBar: new AppBar(
        title: Text(widget.title),
        bottom: TabBar(tabs: _tabs,
          controller: _controller,
          isScrollable: true,
          labelStyle: TextStyle(
            fontSize: 17.0,
          ),),
      ),
      body: new TabBarView(children: _tabView, controller: _controller,),

    );
  }

}

class _FindRecycle extends StatefulWidget {

  String id;

  _FindRecycle(@required this.id);

  @override
  State<StatefulWidget> createState() => _FindContent();

}

class _FindContent extends State<_FindRecycle> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  var _findViewModel = FindDetailViewModel();
  static const int _initPage = 0;
  int _currentPage = _initPage;
  List<HomeArticleEntity> _list = new List();


  @override
  void dispose() {
    _findViewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _findViewModel.getArticles(_currentPage, widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
      stream: _findViewModel.articles,
      builder: (context, snap) {
        _list = snap.data != null ? snap.data : [];
        return RecycleView<HomeArticleEntity>(
          lists: _list,
          loadMore: () {
            _loadData(++_currentPage);
          },
          refresh: () {
            _currentPage = _initPage;
            _loadData(_currentPage);
          },
          itemCount: _list.length,
          listBuilder: _createBuilder,
        );
      },
    );
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
                        color: article.collect ? Colors.red : Colors.black,
                        onPressed: () => _collect(article.courseId, index),
                      ),
                    )
                  ],
                ),
              )),
        ));
  }

  _collect(int courseId, int index) {
    setState(() {
      _list[index].collect = !_list[index].collect;
    });
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
    if (currentPage == _initPage && _list.isNotEmpty) {
      _findViewModel.cleanList();
    }
    await _findViewModel.getArticles(_currentPage, widget.id);
  }

}