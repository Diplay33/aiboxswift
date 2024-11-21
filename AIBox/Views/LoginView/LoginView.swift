//
//  LoginView.swift
//  AIBox
//
//  Created by Jacques HU on 19/11/2024.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @Binding var loginViewState: LoginViewState
    
    var body: some View {
        Spacer()
        
        Text("AI•Box")
            .font(.system(size: 64, design: .rounded))
            .fontWeight(.bold)
            .foregroundStyle(.accent)
            .frame(maxWidth: .infinity)
        
        Spacer()
        
        VStack(spacing: 50) {
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
            
            Button(action: loginButtonOnPress) {
                Text("Connexion")
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
            
            HStack(spacing: 0) {
                Text("Nouveau ? ")
                    .font(.system(size: 18, design: .rounded))
                    .foregroundStyle(Color.accentColor)
                
                Button(action: registerButtonOnPress) {
                    Text("S'enregistrer")
                        .font(.system(size: 18, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.accentColor)
                }
            }
            .padding(.bottom)
        }
    }
    
    private func registerButtonOnPress() {
        withAnimation(.easeOut(duration: 0.3)) {
            loginViewState = .register
        }
    }
    
    private func loginButtonOnPress() {
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: URL(string: "http://88.182.27.68:34000/login")!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["email": self.email.lowercased(), "password": self.password], options: .prettyPrinted)
        session.dataTask(with: request) { data, response, _ in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
        }.resume()
    }
}

#Preview {
    LoginView(loginViewState: .constant(.login))
}
