package com.swyp.haru_up

import android.os.Bundle
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen // 라이브러리 추가 필요
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // 안드로이드 12 스플래시 API 설치
        installSplashScreen()
        
        super.onCreate(savedInstanceState)
    }
}