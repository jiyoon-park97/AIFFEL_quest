import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ChatScreen.dart'; // ✅ ChatScreen 추가
import 'package:url_launcher/url_launcher.dart'; // ✅ url_launcher 추가
import 'SettingScreen.dart';
import 'ThemeProvider.dart';

class HomeScreen extends StatelessWidget {
  final String employment24Url = "https://www.ei.go.kr";
  final String notionNoticeUrl = "https://fuchsia-egg-23e.notion.site/1b6b1e5fe884805e99f2ee85d527cdf6";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor:  themeProvider.isDarkMode ? Colors.black : Colors.yellow, // ✅ 다크 모드 배경 변경
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // ✅ 중앙 정렬
        children: [
          // ✅ 상단 로고
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Image.asset(
              'images/workitalki.png',
              width: 150,
            ),
          ),
          SizedBox(height: 50), // 로고 아래 여백

          // ✅ 2x2 버튼 레이아웃
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircleButton(
                    context, 'images/message.png', '챗봇과 대화하기', ChatScreen(),
                  ),
                  SizedBox(width: 30), // 버튼 사이 간격
                  _buildCircleButton(
                    context, 'images/homepage.png', '고용 24 홈페이지', null,
                    employment24Url,
                  ),
                ],
              ),
              SizedBox(height: 30), // 줄 간격
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildCircleButton(
                    context, 'images/alert.png', '챗봇 공지사항', null, notionNoticeUrl,
                  ),
                  SizedBox(width: 30),
                  _buildCircleButton(
                    context, 'images/setting.png', '설정', SettingsScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🔹 원형 버튼 + 텍스트 + 네비게이션 기능 추가
  Widget _buildCircleButton(BuildContext context, String imagePath,
      String label, Widget? targetScreen, [String? url]) {
    return GestureDetector(
      onTap: () {
        if (targetScreen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => targetScreen),
          );
        } else if (url != null) {
          _launchURL(url);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min, // ✅ 내부 요소 크기에 맞게 조정
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white, // ✅ 원형 버튼 배경색
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 1,
                ),
              ],
            ),
            width: 100, // 원 크기 조절
            height: 100,
            child: Center(
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
              ),
            ),
          ),
          SizedBox(height: 8), // 아이콘과 텍스트 간격
          Text(
            label,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }
}


