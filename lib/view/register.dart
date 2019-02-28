import 'package:flutter/material.dart';
import 'package:wanandroid/viewModel/register_viewmodel.dart';
import 'package:wanandroid/util/utils.dart';
import 'package:wanandroid/entity/login_entity.dart';

class Register extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterState();

}

class _RegisterState extends State<Register> {

  TextEditingController userNameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  RegisterViewModel _viewModel = new RegisterViewModel();

  Function _callBackFunction;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextStyle _style = new TextStyle(letterSpacing: 2.0,
      fontSize: 17,
      color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: Scaffold(
          key: _scaffoldKey,
          body: new Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlutterLogo(size: 100,),
                TextField(
                  controller: userNameController,
                  style: _style,
                  decoration: InputDecoration(labelText: "userName"),
                ),
                Padding(padding: const EdgeInsets.only(top: 30),),
                TextField(
                  controller: passwordController,
                  style: _style,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: InputDecoration(labelText: "password",
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 30),),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: RaisedButton(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    onPressed: _doRegister,
                    color: Colors.blue,
                    child: new Text("注册", style: TextStyle(
                        color: Colors.white
                    ),),),
                )
              ],
            ),
          ),
        )
    );
  }

  _doRegister() {
    if (userNameController.text.length < 6) {
      Utils.showSnackBar("用户名不能小于6位", _scaffoldKey);
    } else if (passwordController.text.length < 6) {
      Utils.showSnackBar("密码不能小于6位", _scaffoldKey);
    } else {
      _viewModel.doRegister(userNameController.text,
          passwordController.text,
              (entity) {
            Utils.showSnackBar("注册成功", _scaffoldKey);
            if (entity is UserEntity) {
              new Future.delayed(const Duration(milliseconds: 1500), () =>
                  Navigator.of(context).pop(entity.username));
            }
          }, (error) {
            Utils.showSnackBar(error, _scaffoldKey);
          });
    }
  }

}