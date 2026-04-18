import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haru_up/presentation/pages/login/login_controller.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 로딩 상태 등에 따라 UI 반응 가능
    final loginState = ref.watch(loginControllerProvider);

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
                  onTap: () => ref
                      .read(loginControllerProvider.notifier)
                      .loginWithKakao(),
                  child: Image.asset(
                    'assets/images/login/kakao_login.png',
                    height: 56,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),

                // 네이버 로그인 버튼
                GestureDetector(
                  onTap: () => ref
                      .read(loginControllerProvider.notifier)
                      .loginWithNaver(),
                  child: Image.asset(
                    'assets/images/login/naver_login.png',
                    fit: BoxFit.contain,
                  ),
                ),
                // 로딩 중일 때 인디케이터 표시 가능
                if (loginState.isLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
