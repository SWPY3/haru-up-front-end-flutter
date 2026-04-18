import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
// import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

void main() async {
  // 1. Flutter 엔진 초기화 보장
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 카카오 SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'a22a879bcb46586d971ca49f32388b20',
    loggingEnabled: true,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext contex, WidgetRef ref) {
    return MaterialApp.router(
      title: 'HaruUp',
      theme: AppTheme.light,
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
