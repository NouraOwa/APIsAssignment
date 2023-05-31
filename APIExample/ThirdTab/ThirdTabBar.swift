//
//  ThirdTabBar.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI

struct ThirdTabBar: View {
        @State var selectedTab = 0
        
        var body: some View {
            NavigationStack{
                VStack {
                    TabView {
                        // First tab
                        Quotes()
                            .tabItem {
                                Image(systemName: "house")
                                Text("Home")
                            }
                        
                        // Second tab
                        Facts()
                            .tabItem {
                                Image(systemName: "rectangle.fill.on.rectangle.fill")
                                Text("Feed")
                            }
                        
                        // Third tab
                        RandomJokes()
                            .tabItem {
                                Image(systemName: "person")
                                Text("Profile")
                                
                            }
                        
                        // Fourth tab
                        RandomYesNo()
                            .tabItem {
                                Image(systemName: "flag")
                                Text("Profile")
                                
                            }
                        // Fifth tab
                        FamousQoutes()
                            .tabItem {
                                Image(systemName: "timer")
                                Text("Profile")
                                
                            }
                    }
                }
            }
        }
    }


struct ThirdTabBar_Previews: PreviewProvider {
    static var previews: some View {
        ThirdTabBar()
    }
}
