import 'package:flutter/material.dart';
import './pages/homepage.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyApp();
  }
}
class _MyApp extends State<MyApp> {
 Map<String, ThemeData> themes={'dark':ThemeData.dark(),'light':ThemeData.light()};
 String theme='dark';
  _changeTheme(){
    setState((){
      theme=='dark'?theme='ligth':theme='dark';
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themes[theme],
      home: HomePage(_changeTheme),
    );
  }
}