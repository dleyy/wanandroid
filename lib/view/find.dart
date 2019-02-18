import 'package:flutter/material.dart';
import 'package:wanandroid/widget/recycle_view.dart';
import 'package:wanandroid/res/constant.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Find();

}

class _Find extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder(stream: null, builder: (context, snap) {
      var list = [3, 3, 3];
      return new Scaffold(
          body: RecycleView(lists: list,
              listBuilder: _createItemBuilder,
          itemCount: 3,)
      );
    });
  }


  _createItemBuilder(BuildContext context, int index) {
    return new GestureDetector(
      onTap: _childClicked(index),
      child: new Card(
        elevation: Values.card_elevation,
        child: new Container(
          padding: EdgeInsets.only(left: Values.horizontal_padding,
              right: Values.horizontal_padding,top: Values.vertical_padding,
          bottom: Values.vertical_padding),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("安卓基础", style: TextStyle(fontWeight: FontWeight.bold,
              fontSize: Values.title_font_size)),
              new Row(children: <Widget>[
                Text("3分类", style: TextStyle(
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

  }
}