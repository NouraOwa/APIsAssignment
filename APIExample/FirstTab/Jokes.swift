//
//  Jokes.swift
//  APIExample
//
//  Created by Noura Alowayid on 10/11/1444 AH.
//

import SwiftUI

struct JokesAPI: Codable, Identifiable{
    let id: Int
    let joke: String
}
struct Jokes: View {
        @State private var jokee = [JokesAPI]()
        var body: some View {
            ScrollView{
                VStack {
                    Text("Take a minute to laugh").font(.largeTitle).bold()
                    Text("😂").font(.largeTitle)
                    ForEach (jokee) { item in
                        VStack {
                            Text(item.joke)
                                .frame (maxWidth: .infinity)
                                .foregroundColor (.black)
                                .font (.title2)
                                .padding(.all, 24)
                                .background (.red.opacity(0.3))
                                .padding (.bottom, 30)
                        }
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
                let url = URL(string: "https://jokes34.p.rapidapi.com/v1/jokes?limit=20&page=1")!
                var request = URLRequest (url: url)
                request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                    "X-RapidAPI-Key")
                
                let (data, _) = try await URLSession.shared.data(for: request)
                
                print(String(data: data, encoding: .utf8))
                let serverJoke = try JSONDecoder().decode([JokesAPI].self, from: data)
                jokee = serverJoke
                
            } catch {
                print("error \(error)")
            }
        }
        
    }

struct Jokes_Previews: PreviewProvider {
    static var previews: some View {
        Jokes()
    }
}
