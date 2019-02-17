import 'package:flutter/material.dart';

class Dialogg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Dia();
}

class _Dia extends State<Dialogg> {
  String _contentText = "6666666666666";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: RaisedButton(
        onPressed: _showDialog,
        child: Text(_contentText),
      ),
    ));
  }

  _showDialog() async {
    var value = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
              content: Text("TTTTTTTTTT"),
              actions: <Widget>[
                FlatButton(
                  child: Text("su  null"),
                  onPressed: () {
                    setState(() {
                      _contentText = "sure";
                    });
                    Navigator.of(_).pop();
                  },
                ),
                FlatButton(
                  child: Text("true"),
                  onPressed: () {
                    setState(() {
                      _contentText = "cancle";
                    });
                    Navigator.of(_).pop(true);
                  },
                ),
                FlatButton(
                  child: Text("cancle false"),
                  onPressed: () {
                    setState(() {
                      _contentText = "cancle";
                    });
                    Navigator.of(_).pop(false);
                  },
                ),
              ],
            ));

    print("this is $value");
  }
}
