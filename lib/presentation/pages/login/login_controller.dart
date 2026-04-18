import 'package:flutter/foundation.dart';
import 'package:flutter_naver_login/interface/types/naver_login_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

// 로그인 상태를 관리하는 Provider
final loginControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue<void>>((ref) {
      return LoginController();
    });

class LoginController extends StateNotifier<AsyncValue<void>> {
  LoginController() : super(const AsyncValue.data(null));

  Future<void> loginWithKakao() async {
    state = const AsyncValue.loading(); // 로딩 상태 시작

    try {
      bool isInstalled = await isKakaoTalkInstalled();
      OAuthToken token = isInstalled
          ? await UserApi.instance.loginWithKakaoTalk()
          : await UserApi.instance.loginWithKakaoAccount();

      User user = await UserApi.instance.me();

      // ✅ 사용자 정보 로그
      debugPrint('===== 카카오 로그인 성공 =====');
      debugPrint('사용자 ID: ${user.id}');
      debugPrint('닉네임: ${user.kakaoAccount?.profile?.nickname}');
      debugPrint('이메일: ${user.kakaoAccount?.email}');
      debugPrint('프로필 이미지: ${user.kakaoAccount?.profile?.profileImageUrl}');
      debugPrint('토큰 accessToken: ${token.accessToken}');
      debugPrint('토큰 만료시간: ${token.expiresAt}');
      debugPrint('==============================');

      // 성공 시 사용자 정보 가져오기 등 추가 로직 수행 가능
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      debugPrint('카카오 로그인 실패: $e');
      state = AsyncValue.error(e, stack); // 에러 상태 전달
    }
  }

  // 네이버 로그인
  Future<void> loginWithNaver() async {
    state = const AsyncValue.loading();
    try {
      final result = await FlutterNaverLogin.logIn();

      if (result.status == NaverLoginStatus.loggedIn) {
        final res = await FlutterNaverLogin.getCurrentAccessToken();
        debugPrint('네이버 로그인 성공: ${result.accessToken}');
        debugPrint('사용자 이메일: ${result.account?.email}');
        var accessToken = res.accessToken;
        var tokenType = res.tokenType;
        debugPrint('accessToken: $accessToken');
        debugPrint('tokenType: $tokenType');

        state = const AsyncValue.data(null);

        // TODO: 여기서 백엔드 서버에 accessToken을 전달하거나 홈 화면으로 이동하세요.
      } else if (result.status.name == 'cancelledByUser') {
        debugPrint('⚠️ [Naver Login] 사용자가 로그인을 취소했습니다.');
        state = const AsyncValue.data(null);
      } else {
        debugPrint('❌ [Naver Login] 로그인 실패: ${result.errorMessage}');
        debugPrint(
          '❌ [Naver Login] 상세 결과: status=${result.status}, msg=${result.errorMessage}',
        );
        state = AsyncValue.error(
          result.errorMessage ?? '알 수 없는 로그인 에러가 발생했습니다.',
          StackTrace.current,
        );
      }
    } catch (e, stack) {
      debugPrint('🚨 [Naver Login] 시스템 에러: $e');
      state = AsyncValue.error(e, stack);
    }
  }
}
