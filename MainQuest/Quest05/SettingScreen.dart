import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ThemeProvider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("설정")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Consumer<ThemeProvider>( // ✅ Provider 범위 내에서 UI 업데이트
          builder: (context, themeProvider, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ 다크 모드 스위치
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("다크 모드", style: TextStyle(fontSize: themeProvider.fontSize)),
                    Switch(
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleDarkMode();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // ✅ 폰트 크기 조절 (라디오 버튼)
                Text("폰트 크기", style: TextStyle(fontSize: themeProvider.fontSize)),
                Column(
                  children: [
                    _buildFontSizeOption(context, "작음", 14.0),
                    _buildFontSizeOption(context, "기본", 16.0),
                    _buildFontSizeOption(context, "큼", 20.0),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // 🔹 폰트 크기 선택 라디오 버튼
  Widget _buildFontSizeOption(BuildContext context, String label, double size) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return RadioListTile<double>(
          title: Text(label, style: TextStyle(fontSize: size)),
          value: size,
          groupValue: themeProvider.fontSize,
          onChanged: (value) {
            if (value != null) {
              themeProvider.setFontSize(value);
            }
          },
        );
      },
    );
  }
}
