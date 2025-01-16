//
//  RegisterView.swift
//  AIBox
//
//  Created by Jacques HU on 19/11/2024.
//

import SwiftUI

struct RegisterView: View {
    @State var email: String = ""
    @State var username: String = ""
    @State var password: String = ""
    
    @Binding var loginViewState: LoginViewState
    
    var body: some View {
        ZStack {
            Button(action: backButtonOnpress) {
                HStack {
                    Image(systemName: "chevron.left")
                    
                    Text("Retour")
                        .font(.system(size: 18, design: .rounded))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding()
            
            VStack(spacing: 50) {
                Text("Inscription")
                    .font(.system(size: 48, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.accent)
                    .frame(maxWidth: .infinity)
                
                VStack(spacing: 15) {
                    TextField("adresse email", text: $email)
                        .font(.system(size: 18, design: .rounded))
                        .frame(height: 50)
                        .padding(.horizontal)
                        .background(.white.opacity(0.5))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.accentColor)
                        )
                        .padding(.horizontal)
                    
                    TextField("username", text: $username)
                        .font(.system(size: 18, design: .rounded))
                        .frame(height: 50)
                        .padding(.horizontal)
                        .background(.white.opacity(0.5))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.accentColor)
                        )
                        .padding(.horizontal)
                    
                    SecureField("mot de passe", text: $password)
                        .font(.system(size: 18, design: .rounded))
                        .frame(height: 50)
                        .padding(.horizontal)
                        .background(.white.opacity(0.5))
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.accentColor)
                        )
                        .padding(.horizontal)
                }
                
                HStack {
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                    
                    Text("Se connecter via")
                        .font(.system(size: 18, design: .rounded))
                        .foregroundStyle(Color.accentColor)
                        .layoutPriority(1)
                    
                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                HStack(spacing: 45) {
                    Image("Google")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                    
                    Image("Apple")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                }
                
                Button(action: registerButtonOnPress) {
                    Text("S'inscrire")
                        .font(.system(size: 18, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.horizontal)
                }
                .shadow(color: Color.black.opacity(0.2), radius: 1, y: 2)
            }
        }
    }
    
    private func backButtonOnpress() {
        withAnimation(.easeOut(duration: 0.3)) {
            loginViewState = .login
        }
    }
    
    private func registerButtonOnPress() {
        let body = [
            "first_name": self.username,
            "email": self.email,
            "password": self.password
        ]
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: URL(string: "http://88.182.27.68:34000/users")!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
        session.dataTask(with: request) { data, response, _ in
            print("ok")
        }.resume()
    }
}

#Preview {
    RegisterView(loginViewState: .constant(.register))
}
