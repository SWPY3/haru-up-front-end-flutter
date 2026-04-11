package com.swyp.haru_up

import android.app.Application
import com.kakao.sdk.common.KakaoSdk

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        KakaoSdk.init(this, "a22a879bcb46586d971ca49f32388b20")
    }
}
