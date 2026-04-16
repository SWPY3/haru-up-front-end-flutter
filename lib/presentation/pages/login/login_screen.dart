import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/login/image_login_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 200,
            left: 20,
            right: 20,
            child: Column(
              children: [
                // 카카오 로그인 버튼
                GestureDetector(
                  onTap: () {
                    //TODO: 카카오 로그인 로직
                  },
                  child: Image.asset(
                    'assets/images/login/kakao_login.png',
                    height: 56,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),

                // 네이버 로그인 버튼
                GestureDetector(
                  onTap: () {
                    //TODO: 네이버 로그인 로직
                  },
                  child: Image.asset(
                    'assets/images/login/naver_login.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
