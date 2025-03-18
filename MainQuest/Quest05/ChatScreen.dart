import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'DifyService.dart'; // ✅ DifyService 가져오기
import 'ThemeProvider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final DifyService _difyService = DifyService(); // ✅ DifyService 인스턴스 생성
  List<Map<String, String>> messages = [];

  Future<void> sendMessage(String userMessage) async {
    if (userMessage.trim().isEmpty) return;

    setState(() {
      messages.add({"sender": "user", "message": userMessage});
    });

    _controller.clear();

    try {
      print("📡 Dify에게 메시지 전송: $userMessage"); // ✅ 요청 로그 출력
      String aiResponse = await _difyService.getChatbotResponse(userMessage);
      print("📡 Dify 응답 받음: $aiResponse"); // ✅ 응답 로그 출력

      setState(() {
        messages.add({"sender": "ai", "message": aiResponse});
      });
    } catch (e) {
      print("🚨 네트워크 오류 발생: $e");
      setState(() {
        messages.add({"sender": "ai", "message": "⚠️ 네트워크 오류가 발생했습니다."});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.yellow[100], // ✅ 연한 노란색 배경
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // ✅ 상단바 높이 조정
        child: AppBar(
          backgroundColor: themeProvider.isDarkMode ? Colors.grey[900] : Colors.yellow, // ✅ 상단바 색상
          centerTitle: true,
          elevation: 0,
          title: Image.asset(
            'images/workitalki.png', // ✅ 로고 이미지
            width: 80,
          ),
        ),
      ),
      body: Column(
        children: [
          // ✅ 채팅 메시지 영역
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                bool isUser = messages[index]["sender"] == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? (themeProvider.isDarkMode ? Colors.blueGrey[700] : Colors.yellow) : (themeProvider.isDarkMode ? Colors.grey[800] : Colors.white),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      messages[index]["message"]!,
                      style: TextStyle(fontSize: themeProvider.fontSize, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),

          // ✅ 입력창 + 전송 버튼
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            color: themeProvider.isDarkMode ? Colors.grey : Colors.yellow, // ✅ 입력창 배경색
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "메시지 입력...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => sendMessage(_controller.text),
                  child: Icon(Icons.send, color: Colors.black, size: 28),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
