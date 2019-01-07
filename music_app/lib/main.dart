import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

import 'package:music_app/login.dart';
import 'package:music_app/index.dart';

void main() => runApp(new MyApp());

var _isLogin = false;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Netease Clound Misic Demo',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new Index(),
    ); /*  */
  }
}
