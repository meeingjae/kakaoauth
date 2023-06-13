//
//  kakaoauthApp.swift
//  kakaoauth
//
//  Created by Ming on 2023/06/12.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct kakaoauthApp: App {
    
    init() {
        // Kakao SDK 초기화
        let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as? String ?? ""
        KakaoSDK.initSDK(appKey: kakaoAppKey)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL { url in
                    if (AuthApi.isKakaoTalkLoginUrl(url)) {
                        _ = AuthController.handleOpenUrl(url: url)
                    }
                }
        }
    }
}
