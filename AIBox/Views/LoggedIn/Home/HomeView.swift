//
//  HomeView.swift
//  AIBox
//
//  Created by Jacques HU on 16/01/2025.
//

import SwiftUI
import Charts

struct HomeView: View {
    @State private var data: [ChartData] = generateRandomData()
    
    var body: some View {
        OnBoardingBackground {
            VStack {
                ZStack {
                    HStack {
                        Text("Accueil")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                    .padding(.horizontal)
                    .frame(maxHeight: .infinity, alignment: .top)
                    
                    VStack {
                        Spacer()
                        
                        Text("~6")
                            .font(.system(size: 96, weight: .bold, design: .rounded))
                        
                        Spacer()
                        
                        Text("éléments dans votre boîte aux lettres")
                            .font(.system(size: 36, weight: .bold, design: .rounded))
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                    }
                }
                .padding(.top, 75)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.accent.opacity(0.08))
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .ignoresSafeArea(.all)
                .padding(.horizontal, 5)
                
                HStack {
                    Chart {
                        ForEach(data) { item in
                            LineMark(
                                x: .value("Jour", item.day),
                                y: .value("Unité", item.units)
                            )
                            .symbol(Circle())
                            .foregroundStyle(Color.accentColor)
                            
                            PointMark(
                                x: .value("Jour", item.day),
                                y: .value("Unité", item.units)
                            )
                            .foregroundStyle(.black)
                        }
                    }
                    .padding(30)
                    .frame(maxWidth: .infinity, maxHeight: 250)
                    .background(.accent.opacity(0.45))
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    
                    VStack {
                        VStack {
                            Text("Ouvert à")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                            
                            Text("14h24")
                                .font(.system(size: 44, weight: .bold, design: .rounded))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.accent.opacity(0.25))
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                        
                        VStack {
                            Image(systemName: "camera")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            
                            Text("Prendre une photo")
                                .font(.system(size: 18, weight: .bold, design: .rounded))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.accent.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 50))
                    }
                    .frame(maxHeight: 250)
                }
                .padding(.horizontal)
            }
        }
    }
    
    static func generateRandomData() -> [ChartData] {
        let days = ["Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi", "Dimanche"]
        return days.map { day in
            ChartData(day: day, units: Int.random(in: 1...10))
        }
    }
}

struct ChartData: Identifiable {
    let id = UUID()
    let day: String
    let units: Int
}

#Preview {
    HomeView()
}
