import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uuid/uuid.dart';

class DifyService {
  final String apiUrl = "https://api.dify.ai/v1/chat-messages"; // 🔗 Dify API 엔드포인트 입력
  final String apiKey = "difyapi"; // 🔑 Dify API 키 입력
  final String userId = Uuid().v4(); // ✅ 사용자 ID

  // Dify에 메시지를 보내고 응답을 받는 함수
  Future<String> getChatbotResponse(String userMessage) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiKey",
      },
      body: jsonEncode({
        "query": userMessage,
        "user": userId,
        "inputs": null // ✅ 필수: inputs 추가
      }),
    );

    print("📢 Dify API 응답: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(utf8.decode(response.bodyBytes));
      if (data["answer"] != null) {
        return data["answer"]; // ✅ 응답 제대로 가져오기
      } else {
        return "⚠️ Dify 응답이 비어 있습니다.";
      }
    } else {
      return "❌ 오류 발생: ${response.statusCode} - ${response.body}";
    }
  }
}

