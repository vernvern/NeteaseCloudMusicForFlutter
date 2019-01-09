import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  @override
  createState() => new LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final accountController = new TextEditingController();
  final passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      /*   appBar: new AppBar(
        title: new Text('login test'),
      ),
      */
      body: new Stack(
        children: <Widget>[
          // _background(),
          _loginForm(context),
        ],
      ),
    );
  }

  Widget _background() {
    return new Image();
  }

  Widget _loginForm(BuildContext context) {
    EdgeInsets inputPadding =
        new EdgeInsets.symmetric(horizontal: 120.0, vertical: 2.5);
    return new Padding(
      padding: new EdgeInsets.only(top: 0.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: inputPadding,
            child: new TextField(
              controller: accountController,
              decoration: new InputDecoration(
                hintText: 'account',
              ),
            ),
          ),
          new Padding(
            padding: inputPadding,
            child: new TextField(
              obscureText: true,
              controller: passwordController,
              decoration: new InputDecoration(
                hintText: 'password',
              ),
            ),
          ),
          new Padding(
            padding: inputPadding,
            child: new RaisedButton(
              child: Text('login'),
              onPressed: () {
                showDialog(
                    context: context,
                    child: new AlertDialog(
                      title: new Text('test alertDiaLog title'),
                      content: new Text(accountController.text),
                    ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
