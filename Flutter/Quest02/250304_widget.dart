import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
               title: Container(
                    height: 48.0,
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: Text('플러터 앱 만들기')),
              leading: Icon(Icons.icecream),
              ),
              ),
            );
  }
  @override
    Widget build(BuildContext context){
      return Scaffold(
        body: Center(
          child: ElevatedButton (
            onPressed: () {
              print('버튼이 눌렸습니다.');
            }, child: Text('Text'),
            style: ButtonStyle( backgroundColor: MaterialStateProperty.all(Colors.blue)
          ),
        ),
        ),
        );

    }


