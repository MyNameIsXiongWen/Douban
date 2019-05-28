import 'package:flutter/material.dart';
import 'package:hhh/utils/common.dart';
import 'package:hhh/utils/http_manager.dart';
import 'package:hhh/utils/http_address.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _phoneNumber;
  String _password;
  bool _codeLogin = true;

  _login() {
    var _form = _formKey.currentState;
    if (_form.validate()) {
      _form.save();
      print(_phoneNumber);
      print(_password);
    }
    _loginRequest();
  }

  _loginRequest() {
    HttpManager.post('', Util.kMankuSystemAdmin + HttpAddress.kUserLogin,
        {'username': _phoneNumber, 'password': _password}, (data) {
      print('success=$data');
      Util.addSharePreference('token', data['token'].toString());
      Util.addSharePreference('shopId', data['shop'][0]['shopId'].toString());
      _getUserinfoRequest();
    }, errorCallBack: (errorMsg) {
      print('error=$errorMsg');
    });
  }

  _getUserinfoRequest() {
    HttpManager.post(
        '',
        Util.kMankuSystemAdmin + HttpAddress.kUserShopLogin + Util.shopId,
        {}, (data) {
      print('success=$data');
    }, errorCallBack: (errorMsg) {
      Util.addSharePreference('token', '');
      Util.addSharePreference('shopId', '');
      print('error=$errorMsg');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 40),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      _codeLogin ? '短信验证登录/注册' : '账号密码登录',
                      style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    ),
                    _codeLogin
                        ? Text(
                            '登录注册表示同意 使用协议、隐私政策',
                            style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.black45,
                                fontWeight: FontWeight.w400),
                          )
                        : Container(),
                    buildTextfieldForm(),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4.0)),
                          width: 335,
                          height: 40,
                          child: Center(
                            child: Text(
                              '登录',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        onTap: _login,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _codeLogin = !_codeLogin;
                            });
                          },
                          child: Text(_codeLogin ? '账号密码登录' : '短信验证登录 / 注册',
                              style:
                                  TextStyle(color: Colors.green, fontSize: 14)),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(_codeLogin ? '收不到验证码？' : '找回密码',
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 14)),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0,
                top: 10,
                child: GestureDetector(
                  child: Image.asset(
                    'images/close.png',
                    height: 25,
                  ),
                  onTap: () => print('object'),
                )),
            Positioned(
                bottom: 100,
                left: (MediaQuery.of(context).size.width - 160) / 2,
                child: Container(
                    width: 120,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text('第三方登录'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  'images/zhifubao.png',
                                  height: 40,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  'images/jingdong.png',
                                  height: 40,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }

  Widget buildTextfieldForm() {
    return Container(
        margin: EdgeInsets.only(top: 30, bottom: 20),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black26, width: 0.5),
            borderRadius: BorderRadius.circular(5.0)),
        child: Stack(
          children: <Widget>[
            Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                        validator: (value) {
                          _phoneNumber = value;
                        },
                        autovalidate: true,
                        keyboardType: TextInputType.phone,
                        decoration: _codeLogin
                            ? InputDecoration(
                                border: InputBorder.none,
                                hintText: '手机号',
                                icon: Text('+86',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 13)),
                              )
                            : InputDecoration(
                                border: InputBorder.none,
                                hintText: '手机号 / 邮箱',
                              )),
                    Divider(
                      height: 0.5,
                      color: Colors.black,
                    ),
                    TextFormField(
                      validator: (value) {
                        _password = value;
                      },
                      autovalidate: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: _codeLogin ? '验证码' : '密码',
                      ),
                    )
                  ],
                )),
            Positioned(
                right: 10,
                bottom: 12,
                child: GestureDetector(
                  child: _codeLogin
                      ? Text(
                          '获取验证码',
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        )
                      : Container(),
                  onTap: () {
                    print('$_password');
                  },
                ))
          ],
        ));
  }
}
