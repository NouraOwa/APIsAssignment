//
//  SecondTabBar.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI

struct SecondTabBar: View {
    @State var selectedTab = 0
    
    var body: some View {
        NavigationStack{
            VStack {
                TabView {
                    // First tab
                    Reciepe()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    
                    // Second tab
                    PlanetList()
                        .tabItem {
                            Image(systemName: "rectangle.fill.on.rectangle.fill")
                            Text("Feed")
                        }
                    
                    // Third tab
                    CountriesFlags()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                            
                        }
                    
                    // Fourth tab
                    CoinFlip()
                        .tabItem {
                            Image(systemName: "flag")
                            Text("Profile")
                            
                        }
                    // Fiveth tab
                    News()
                        .tabItem {
                            Image(systemName: "timer")
                            Text("Profile")
                            
                        }
                }
            }
        }
    }
}

struct SecondTabBar_Previews: PreviewProvider {
    static var previews: some View {
        SecondTabBar()
    }
}
