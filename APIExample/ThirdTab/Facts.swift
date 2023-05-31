//
//  Facts.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI
struct Fact: Codable {
    let fact: String}

struct Facts: View {
        @State private var fact = Fact(fact: "")
        var body: some View {
            ScrollView{
                VStack {
                    Text("Today's Fact").font(.largeTitle).bold()
                        .padding()
                    Text(fact.fact)
                        .frame(maxWidth: .infinity)
                        .font(.title)
                        .background (.gray.opacity(0.3))
                        .padding(.leading)

                }
            }
            .task {
                await loadData ()
            }
        }
        
        func loadData( ) async {
            do {
                //                try! await Task.sleep(nanoseconds: 3_000_000_000)
                let url = URL(string: "https://random-quote-fact-joke-api.p.rapidapi.com/fact")!
                var request = URLRequest (url: url)
                request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                    "X-RapidAPI-Key")
                
                let (data, _) = try await URLSession.shared.data(for: request)
                
                print(String(data: data, encoding: .utf8))
                let serverFact = try JSONDecoder().decode(Fact.self, from: data)
                fact = serverFact
                
            } catch {
                print("error \(error)")
            }
        }
        
    }

struct Facts_Previews: PreviewProvider {
    static var previews: some View {
        Facts()
    }
}
