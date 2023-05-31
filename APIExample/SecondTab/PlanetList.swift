//
//  PlanetList.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI
struct PlanetNames: Codable, Identifiable{
    let id = UUID()
    let name: String
    let description: String
}
struct PlanetList: View {
    @State private var planet = [PlanetNames]()
    var body: some View {
        ScrollView{
            VStack {
                Text("PLANETS NAME").font(.largeTitle).bold()
                ForEach (planet) { item in
                    VStack {
                        Text(item.name).font(.title2).bold()
                        Text(item.description)
                            .frame (maxWidth: .infinity)
                            .foregroundColor (.black)
                            .font (.title2)
                            .padding(.all, 24)
                            .background (.cyan.opacity(0.3))
                    }.padding()
                }
            }
        }
        .task {
            await loadData ()
        }
    }

    func loadData( ) async {
        do {
            //                try! await Task.sleep(nanoseconds: 3_000_000_000)
            let url = URL(string: "https://planets-info-by-newbapi.p.rapidapi.com/api/v1/planets/")!
            var request = URLRequest (url: url)
            request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                "X-RapidAPI-Key")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print(String(data: data, encoding: .utf8))
            
            let serverWord = try JSONDecoder().decode([PlanetNames].self, from: data)
            planet = serverWord
            
        } catch {
            print("error \(error)")
        }
    }
}


struct PlanetList_Previews: PreviewProvider {
    static var previews: some View {
        PlanetList()
    }
}
