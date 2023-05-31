//
//  CitiesAPI.swift
//  APIExample
//
//  Created by Noura Alowayid on 10/11/1444 AH.
//

import SwiftUI
struct City: Codable, Identifiable{
    let city_name: String
    let country_code: String
    
    var id: String {
        city_name
    }
}
struct CitiesAPI: View {
    @State private var city = City(city_name: "", country_code: "")
    
    var body: some View {
        ScrollView{
            
            VStack {
                Text(city.city_name)
                    .frame (maxWidth: .infinity)
                    .foregroundColor (.white)
                    .font (.title2)
                    .padding(.all, 24)
                    .background (.gray)
                    .padding (.bottom, 30)
                Text (city.country_code)
                    .frame (maxWidth: .infinity)
                    .foregroundColor (.white)
                    .font (.title2)
                    .padding(.all, 24)
                    .background (.gray)
                    .padding (.bottom, 30)
            }
        }
            .task {
                await loadData()
            }
        }
        
        func loadData( ) async {
            do {
                //                try! await Task.sleep(nanoseconds: 3_000_000_000)
                let url = URL(string: "https://weatherbit-v1-mashape.p.rapidapi.com/forecast/daily?lat=38.5&lon=-78.5")!
                var request = URLRequest (url: url)
                request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                    "X-RapidAPI-Key")
                
                let (data, _) = try await URLSession.shared.data(for: request)
                
                print(String(data: data, encoding: .utf8))
                
                let serverCity = try JSONDecoder().decode(City.self, from: data)
                city = serverCity
                
            } catch {
                print("error \(error)")
            }
        }
        
    }
struct CitiesAPI_Previews: PreviewProvider {
    static var previews: some View {
        CitiesAPI()
    }
}
