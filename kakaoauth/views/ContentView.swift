//
//  ContentView.swift
//  kakaoauth
//
//  Created by Ming on 2023/06/12.
//

import SwiftUI
import KakaoSDKUser
import KakaoSDKAuth

struct ContentView: View {
    
    var body: some View {
        MainView()
    }
}

struct MainView: View {
    @State private var currentUser:User? = nil
    
    var body: some View {
        Group {
            if let user = currentUser {
                KakaoUserDetailView(currentUser: $currentUser)
            } else {
                VStack {
                    Button {
                        print("hasToken : " , AuthApi.hasToken())
                        if (UserApi.isKakaoTalkLoginAvailable()) {
                            UserApi.shared.loginWithKakaoTalk { (oAuthToken, error) in
                                if let error = error {
                                    print(error as Any)
                                }
                                else {
                                    let accessToken:String = oAuthToken?.accessToken ?? ""
                                    print(oAuthToken as Any)
                                    print("access token : " + accessToken)
                                    
                                    UserApi.shared.me { (user, error) in
                                        if let error = error {
                                            print(error)
                                        }
                                        else {
                                            print("shared me start")
                                            if let user = user {
                                                var scopes = [String]()
                                                if(user.kakaoAccount?.profileNeedsAgreement == true) {scopes.append("profile")}
                                                if(user.kakaoAccount?.emailNeedsAgreement == true) {scopes.append("account_email")}
                                                if(user.kakaoAccount?.birthdayNeedsAgreement == true) {scopes.append("birthday")}
                                                if(user.kakaoAccount?.birthyearNeedsAgreement == true) {scopes.append("birthyear")}
                                                if(user.kakaoAccount?.genderNeedsAgreement == true) {scopes.append("gender")}
                                                if(user.kakaoAccount?.phoneNumberNeedsAgreement == true) {scopes.append("phone_number")}
                                                if(user.kakaoAccount?.ageRangeNeedsAgreement == true) {scopes.append("age_range")}
                                                if(user.kakaoAccount?.ciNeedsAgreement == true) {scopes.append("account_ci")}
                                                
                                                if scopes.count > 0 {
                                                    print("사용자에게 추가 동의를 받아야 합니다")
                                                    
                                                    UserApi.shared.loginWithKakaoAccount(scopes: scopes) { (_, error) in
                                                        if let error = error {
                                                            print(error)
                                                        }
                                                        else {
                                                            UserApi.shared.me { (user, error) in
                                                                if let error = error {
                                                                    print(error)
                                                                }
                                                                else {
                                                                    print("me() success")
                                                                    self.currentUser = user
                                                                    
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        } else {
                            UserApi.shared.loginWithKakaoAccount { (oAuthToken, error) in
                                if let error = error {
                                    print(error as Any)
                                }
                                else {
                                    print("hasToken : " , AuthApi.hasToken())
                                    let accessToken:String = oAuthToken?.accessToken ?? ""
                                    print(oAuthToken as Any)
                                    print("access token : " + accessToken)
                                    
                                    UserApi.shared.me { (user, error) in
                                        if let error = error {
                                            print(error)
                                        }
                                        else {
                                            print("shared me start")
                                            if let user = user {
                                                var scopes = [String]()
                                                if(user.kakaoAccount?.profileNeedsAgreement == true) {scopes.append("profile")}
                                                if(user.kakaoAccount?.emailNeedsAgreement == true) {scopes.append("account_email")}
                                                if(user.kakaoAccount?.birthdayNeedsAgreement == true) {scopes.append("birthday")}
                                                if(user.kakaoAccount?.birthyearNeedsAgreement == true) {scopes.append("birthyear")}
                                                if(user.kakaoAccount?.genderNeedsAgreement == true) {scopes.append("gender")}
                                                if(user.kakaoAccount?.phoneNumberNeedsAgreement == true) {scopes.append("phone_number")}
                                                if(user.kakaoAccount?.ageRangeNeedsAgreement == true) {scopes.append("age_range")}
                                                if(user.kakaoAccount?.ciNeedsAgreement == true) {scopes.append("account_ci")}
                                                
                                                if scopes.count > 0 {
                                                    print("사용자에게 추가 동의를 받아야 합니다")
                                                    
                                                    UserApi.shared.loginWithKakaoAccount(scopes: scopes) { (_, error) in
                                                        if let error = error {
                                                            print(error)
                                                        }
                                                        else {
                                                            UserApi.shared.me { (user, error) in
                                                                if let error = error {
                                                                    print(error)
                                                                }
                                                                else {
                                                                    print("me() success")
                                                                    _ = user
                                                                    print(user as Any)
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                                else {
                                                    print("me() success")
                                                    self.currentUser = user
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    } label : {
                        Image(systemName: "app.connected.to.app.below.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .imageScale(Image.Scale.large)
                            .frame(width: UIScreen.main.bounds.width * 0.3)
                    }
                    HStack {
                        Text("This is Kakao Login Button")
                            .shadow(color: Color.blue, radius: CGFloat.pi)
                    }
                }.padding()
                VStack {
                    ShareImage()
                        .frame(width: UIScreen.main.bounds.width * 0.3)
                    Text("This is share button")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct KakaoUserDetailView: View {
    @Binding var currentUser: User?
    
    
    var body: some View {
        VStack {
            List {
                Text("닉네임 : \(currentUser?.kakaoAccount?.profile?.nickname ?? "")")
                Text("이메일 : \(currentUser?.kakaoAccount?.email ?? "")")
                Text("나이 구간 : \(currentUser?.kakaoAccount?.ageRange?.rawValue ?? "")")
                AsyncImage(url: URL(string: currentUser?.kakaoAccount?.profile?.profileImageUrl?.absoluteString as? String ?? ""))
                    .padding()
            }
            .navigationBarTitle("User Info")
            
            Button {
                UserApi.shared.logout { (error) in
                    if let error = error {
                        print(error)
                    } else {
                        NavigationLink(destination: ContentView()) {
                            Text("Go Start Page")
                        }
                    }
                }
            } label: {
                Text("logout")
            }
        }
    }
}
