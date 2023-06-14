//
//  AppDelegate.swift
//  kakaoauth
//
//  Created by Ming on 2023/06/13.
//

import Foundation
import KakaoSDKAuth
import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url)
        }
        return false
    }
}
