import 'package:flutter/material.dart';
import 'login.dart';

class MinePage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _MineState();

}

class _MineState extends State<MinePage> {

  List<String> _options;
  bool _loginState;

  @override
  void initState() {
    _options = ["我的收藏", "我的收藏", "我的收藏", "我的收藏"];
    _loginState = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: _createItemBuilder,
      itemCount: _options.length + 1,
    );
  }


  Widget _createItemBuilder(BuildContext context, int index) {
    if (index == 0) {
      return new Container(
        padding: EdgeInsets.only(top: 20,bottom: 20),
        child: new Card(
            elevation: 5.0,
            child: new InkWell(
              splashColor: Colors.blue,
              onTap: () => _goToLogin(),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.supervised_user_circle,
                    size: 100.0, color: Colors.blue,),
                  Padding(padding: EdgeInsets.only(top: 15)),
                  RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                              text: "当前状态:  ",
                              style:
                              DefaultTextStyle
                                  .of(context)
                                  .style),
                          TextSpan(
                              text: "${_loginState ? "已" : "未"}登录",
                              style: TextStyle(
                                  color: _loginState ? Colors.blue : Colors.red,
                                  fontSize: 15.0))
                        ],
                      )),
                ],
              ),
            )
        ),
      );
    } else {
      return InkWell(
        splashColor: Colors.blue,
        onTap: () => _itemMenuClicked(index - 1),
        child: Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(_options[index - 1], style: TextStyle(
                  fontSize: 16
              ),),
              Icon(Icons.arrow_back, textDirection: TextDirection.rtl,)
            ],
          ),
        ),
      );
    }
  }

  _itemMenuClicked(int index) {
    print(index);
  }

  _goToLogin() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (context)=>Login()));
  }
}