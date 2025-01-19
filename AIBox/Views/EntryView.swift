//
//  EntryView.swift
//  AIBox
//
//  Created by Jacques HU on 19/11/2024.
//

import SwiftUI

struct EntryView: View {
    @AppStorage("userId") var userId: String?
    @State var loginViewState: LoginViewState = .login
    
    var body: some View {
        NavigationStack {
            OnBoardingBackground {
                VStack {
                    switch loginViewState {
                    case .login:
                        LoginView(loginViewState: $loginViewState)
                            .transition(.move(edge: .leading))
                    case .register:
                        RegisterView(loginViewState: $loginViewState)
                            .transition(.move(edge: .trailing))
                    }
                }
            }
            .navigationDestination(item: $userId) { value in
                if value != nil {
                    ConnectWifiView()
                        .navigationBarBackButtonHidden()
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
