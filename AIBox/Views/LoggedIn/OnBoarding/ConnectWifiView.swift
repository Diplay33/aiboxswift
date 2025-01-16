//
//  ConnectWifiView.swift
//  AIBox
//
//  Created by Jacques HU on 13/01/2025.
//

import SwiftUI
import CoreLocation
import SystemConfiguration.CaptiveNetwork

struct ConnectWifiView: View {
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("userId") var userId: String = ""
    @AppStorage("onBoardingDone") var onBoardingDone: Bool = false
    
    var currentNetworkInfos: Array<NetworkInfo>? {
         get {
             return SSID.fetchNetworkInfo()
         }
     }
    
    var body: some View {
        OnBoardingBackground {
            VStack(spacing: 50) {
                Text("Veuillez vous connecter au réseau Wifi \"aibox-x\"")
                    .font(.system(size: 36, design: .rounded))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.accentColor)
                    .padding(.horizontal)

                Button(action: connectWifiButtonOnpress) {
                    Text("Accéder aux Réglages")
                        .font(.system(size: 18, design: .rounded))
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.horizontal)
                }
            }
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            guard newPhase == .inactive && oldPhase == .background else { return }
            checkWifi()
        }
        .navigationDestination(isPresented: $onBoardingDone) {
            HomeView()
                .navigationBarBackButtonHidden()
        }
    }
    
    private func connectWifiButtonOnpress() {
        UIApplication.shared.open(URL(string: "App-Prefs:root=WIFI")!)
    }
    
    private func checkWifi() {
        let locationManager = CLLocationManager()
        if(locationManager.authorizationStatus == .authorizedWhenInUse) {
            if let ssid = currentNetworkInfos?.first?.ssid {
                print("SSID: \(ssid)")
//                guard ssid.contains("aibox-") else { return }
                linkDevicetoUser(ssid)
            }
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func linkDevicetoUser(_ deviceId: String) {
        let session = URLSession(configuration: .default)
        var request = URLRequest(url: URL(string: "http://192.168.1.17:6000/users/link_device")!)
        request.httpMethod = "POST"
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONSerialization.data(withJSONObject: ["user_id": Int(userId) ?? 0, "device_id": deviceId], options: .prettyPrinted)
        session.dataTask(with: request) { data, response, _ in
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                guard httpResponse.statusCode == 201 else { return }
                self.onBoardingDone = true
            }
        }.resume()
    }
}

#Preview {
    ConnectWifiView()
}
