import 'package:flutter/material.dart';
import 'package:wanandroid/res/constant.dart';
import 'package:wanandroid/viewModel/find_viewmodel.dart';
import 'package:wanandroid/entity/find_entity.dart';
import 'find_list.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Find();
}

class _Find extends State<FindPage> with AutomaticKeepAliveClientMixin {


  FindViewModel _find_model = FindViewModel();
  List<FindEntity> _list = new List();

  @override
  void initState() {
    super.initState();
    _find_model.getFindData();
  }

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(stream: _find_model.findLists,
        builder: (context, snap) {
          _list = snap.data == null ? [] : snap.data;
          return new Scaffold(
              body: ListView.builder(
                itemBuilder: _createItemBuilder,
                itemCount: _list.length,)
          );
        });
  }


  Widget _createItemBuilder(BuildContext context, int index) {
    return new GestureDetector(
      onTap: ()=>_childClicked(index),
      child: new Card(
        elevation: Values.card_elevation,
        child: new Container(
          padding: EdgeInsets.only(left: Values.horizontal_padding,
              right: Values.horizontal_padding, top: Values.vertical_padding,
              bottom: Values.vertical_padding),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(_list[index].channelName,
                  style: TextStyle(fontWeight: FontWeight.bold,
                      fontSize: Values.title_font_size)),
              new Row(children: <Widget>[
                Text("${_list[index].children == null ?
                0 : _list[index].children.length}分类", style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.bold,
                    fontSize: Values.title_font_size)),
                Padding(padding: EdgeInsets.only(right: 5.0),),
                Icon(Icons.chevron_right),
              ],)
            ],
          ),
        ),
      ),
    );
  }

  _childClicked(int index) {
    String title = _list[index].channelName;
    String id = _list[index].channelId;
    List<FindEntity> content = _list[index].children;
    Navigator.push(context,
        new MaterialPageRoute(builder:
            (context)=>FindList(title, id, content)));
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _find_model.dispose();
    super.dispose();
  }
}