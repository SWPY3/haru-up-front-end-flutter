import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/router/app_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    _startNavTimer();
  }

  // 2초 뒤 로그인 화면으로 이동
  void _startNavTimer() async {
    // 만약 초기 데이터 로딩이나 로그인 체크가 필요하다면 여기서 수행합니다.
    // 지금은 테스트를 위해 시간만 지연시킵니다.
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      // 이미 설정하신 AppRoutes.login 상수를 사용하세요.
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // 1. 전체 화면 배경 이미지 (수정된 부분)
          SizedBox.expand(
            // 부모 위젯 크기만큼 확장
            child: Image.asset(
              'assets/images/splash/image_splash.png', // 등록한 이미지 경로
              fit: BoxFit.cover, // 이미지가 비율을 유지하며 화면을 가득 채우도록 설정
              // 이미지 로딩 실패 시 대체 영역 (선택사항)
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: theme.scaffoldBackgroundColor, // 대체 배경색
                  child: const Center(
                    child: Text(
                      'HaruUp',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
