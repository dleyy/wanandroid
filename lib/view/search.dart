import 'package:flutter/material.dart';
import 'package:wanandroid/viewModel/hot_key_viewmodel.dart';
import 'package:wanandroid/entity/hot_key_entity.dart';
import 'package:wanandroid/res/constant.dart';
import 'search_result.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Search();

}

class _Search extends State<SearchPage> {

  HotKeyViewModel _hotKeyViewModel = new HotKeyViewModel();
  TextEditingController _searcherController = new TextEditingController();
  bool _showClear = false;
  List<HotKeyEntity> _list = new List();


  @override
  void initState() {
    _hotKeyViewModel.getHotKey();
    super.initState();
  }

  @override
  void dispose() {
    _hotKeyViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(
        stream: _hotKeyViewModel.hotStream,
        builder: (context, snap) {
          _list = snap.data;
          return new Scaffold(
            appBar: AppBar(
              title: TextField(
                controller: _searcherController,
                autofocus: true,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.search,
                onSubmitted: _search,
                onChanged: _onInputChanged,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    border: InputBorder.none,
                    hintText: "搜索",
                    suffixIcon: _showClear ?
                    GestureDetector(
                        child: Icon(Icons.clear, color: Colors.grey,),
                        onTap: _onClearClicked) : null
                ),
              ),
              actions: <Widget>[
                GestureDetector(child: Icon(Icons.search),
                  behavior: HitTestBehavior.translucent,
                  onTap: () => _search(_searcherController.text),),
                Padding(padding: const EdgeInsets.only(right: 20),)
              ],
            ),
            body: Container(
                padding: const EdgeInsets.only(left: 10,
                    right: 10, top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text("大家都在搜", style: TextStyle(
                      fontSize: Values.title_font_size,
                      fontWeight: FontWeight.bold,
                    ),),
                    Padding(padding: const EdgeInsets.only(top: 20),),
                    new Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: _renderHotContainer(),
                    ),
                  ],
                )
            ),
          );
        });
  }

  List<Widget> _renderHotContainer() {
    List<Widget> widgets = new List();
    if (_list != null && _list.length > 0) {
      for (var item in _list) {
        widgets.add(
            new ActionChip(label: new Text(item.name),
                padding: const EdgeInsets.all(5),
                onPressed: () => _search(item.name)));
      }
    }
    return widgets;
  }

  _onInputChanged(String s) {
    if (s != null && s.length > 0 && !_showClear) {
      setState(() {
        _showClear = true;
      });
    } else if (s.length == 0 && _showClear) {
      setState(() {
        _showClear = false;
      });
    }
  }

  _onClearClicked() {
    _searcherController.clear();
    setState(() {
      _showClear = false;
    });
  }

  _search(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    print(value);
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) => SearchResult(value)));
  }
}