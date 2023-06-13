//
//  ContentView.swift
//  kakaoauth
//
//  Created by Ming on 2023/06/12.
//

import SwiftUI
import KakaoSDKUser

struct ContentView: View {
    var body: some View {
        
        VStack {
            MapView()
                .ignoresSafeArea(edges: .top)
                .frame(height: 200)
        }
        
        VStack {
            Button {
                if (UserApi.isKakaoTalkLoginAvailable()) {
                    UserApi.shared.loginWithKakaoTalk { (oAuthToken, error) in
                        print(oAuthToken as Any)
                        print(error as Any)
                    }
                } else {
                    UserApi.shared.loginWithKakaoAccount { (oAuthToken, error) in
                        print(oAuthToken as Any)
                        print(error as Any)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
