//
//  PlanetsAPI.swift
//  APIExample
//
//  Created by Noura Alowayid on 10/11/1444 AH.
//

import SwiftUI
struct Planet: Codable, Identifiable{
    let name: String
    let temperature: Int
    var id: String {
        name
    }
}

struct PlanetsAPI: View {
    @State private var planet = Planet(name: "", temperature: 0 )
    var body: some View {
        ScrollView{
            
            VStack {
                Text(planet.name)
                    .frame (maxWidth: .infinity)
                    .foregroundColor (.white)
                    .font (.title2)
                    .padding(.all, 24)
                    .background (.gray)
                    .padding (.bottom, 30)
                Text("\(planet.temperature)")
        }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData( ) async {
        do {
            //                try! await Task.sleep(nanoseconds: 3_000_000_000)
            let name = "Neptune".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: "https://api.api-ninjas.com/v1/planets?name="+name!)!
            var request = URLRequest (url: url)
            request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField:
                                "X-Api-Key")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print(String(data: data, encoding: .utf8))
            
            let serverPlanet = try JSONDecoder().decode(Planet.self, from: data)
            planet = serverPlanet
            
        } catch {
            print("error \(error)")
        }
    }
}

struct PlanetsAPI_Previews: PreviewProvider {
    static var previews: some View {
        PlanetsAPI()
    }
}
