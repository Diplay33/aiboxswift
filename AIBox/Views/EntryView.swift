//
//  EntryView.swift
//  AIBox
//
//  Created by Jacques HU on 19/11/2024.
//

import SwiftUI

struct EntryView: View {
    @State var loginViewState: LoginViewState = .login
    
    var body: some View {
        OnBoardingBackground {
            switch loginViewState {
            case .login:
                LoginView(loginViewState: $loginViewState)
                    .transition(.move(edge: .leading))
            case .register:
                Text("Inscription")
                    .transition(.move(edge: .trailing))
                    .onTapGesture {
                        withAnimation {
                            loginViewState = .login
                        }
                    }
            }
        }
    }
}

enum LoginViewState/*: CaseIterable*/ {
    case login, register
}

#Preview {
    EntryView()
}