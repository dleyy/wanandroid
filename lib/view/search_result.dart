import 'package:flutter/material.dart';
import 'package:wanandroid/viewModel/search_result_viewmodel.dart';
import 'common_article_list.dart';
import 'package:wanandroid/entity/home_article_entity.dart';

class SearchResult extends StatefulWidget {

  String keywords;

  SearchResult(this.keywords) :assert(keywords != null);

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State<SearchResult> {

  static const int _state_page = 0;
  List<HomeArticleEntity> _list = new List();
  SearchResultViewModel _viewModel = new SearchResultViewModel();

  @override
  void initState() {
    _viewModel.getSearchResult(_state_page, widget.keywords);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _viewModel.articleStream,
      builder: (context, snap) {
        _list = snap.data != null ? snap.data : [];
        return new Scaffold(
          appBar: AppBar(
            title: Text(widget.keywords),
          ),
          body: new CommonArticleList(
              _list, _loadData, _clearData),
        );
      },
    );
  }

  _loadData(int currentPage) {
    _viewModel.getSearchResult(currentPage, widget.keywords);
  }

  _clearData() {
    _viewModel.clearData();
  }

}