import 'package:aiffel_flutter_project/250317_mainquest/HomeScreen.dart';
import 'package:aiffel_flutter_project/250317_mainquest/ChatScreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';


void main() {
  runApp(MyApp());
}

// 🏠 전체 앱을 감싸는 MyApp 위젯
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WorkiTalki',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FirstScreen(), // ✅ 첫 화면 실행
    );
  }
}

// 🎬 1️⃣ FirstScreen → 5초 후 MainScreen 이동
class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    // 5초 후 MainScreen으로 이동
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow, // ✅ 배경색을 노란색으로 설정
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/workitalki.png', // ✅ 추가한 이미지 파일 (assets 폴더에 있어야 함)
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20), // 간격 추가
          ],
        ),
      ),
    );
  }
}
