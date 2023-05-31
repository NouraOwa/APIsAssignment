//
//  TabBar.swift
//  APIExample
//
//  Created by Noura Alowayid on 10/11/1444 AH.
//

import SwiftUI

struct TabBar: View {
    @State var selectedTab = 0
    
    var body: some View {
        NavigationStack{
            VStack {
                TabView {
                    // First tab
                    IMDpMovies()
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                    
                    // Second tab
                   Jokes()
                        .tabItem {
                            Image(systemName: "rectangle.fill.on.rectangle.fill")
                            Text("Feed")
                        }
                    
                    // Third tab
                    CitiesAPI()
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                            
                        }
                    
                    // Third tab
                    RandomWord()
                        .tabItem {
                            Image(systemName: "flag")
                            Text("Profile")
                            
                        }
                    // Third tab
                    PlanetsAPI()
                        .tabItem {
                            Image(systemName: "timer")
                            Text("Profile")
                            
                        }
                }
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
