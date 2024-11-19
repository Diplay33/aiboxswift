//
//  OnBoardingBackground.swift
//  AIBox
//
//  Created by Jacques HU on 19/11/2024.
//

import SwiftUI

struct OnBoardingBackground<Content: View>: View {
    var contentView: () -> Content
    
    init(@ViewBuilder contentView: @escaping () -> Content) {
        self.contentView = contentView
    }
    
    var body: some View {
        contentView()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [.white, .accentColor]), startPoint: .init(x: 0.79, y: 0.09), endPoint: .init(x: -3, y: 1.5)).ignoresSafeArea())
    }
}

#Preview {
    OnBoardingBackground {
        Text("Hello, World!")
    }
}
