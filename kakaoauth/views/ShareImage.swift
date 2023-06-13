//
//  CircleImage.swift
//  kakaoauth
//
//  Created by Ming on 2023/06/13.
//

import Foundation
import SwiftUI

struct ShareImage: View {
    var body: some View {
        Image(systemName: "square.and.arrow.up.circle")
            .clipShape(Circle())
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        ShareImage()
    }
}
