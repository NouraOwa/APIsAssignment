//
//  RandomJokes.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI
struct Randomjokes: Codable {
    let joke: String
}

struct RandomJokes: View {
            @State private var joke = Randomjokes(joke: "")
            var body: some View {
                ScrollView{
                    VStack {
                        Text("Today's Jokes").font(.largeTitle).bold()
                            .padding()
                        Text(joke.joke)
                            .frame(maxWidth: .infinity)
                            .font(.title)
                            .background (.yellow.opacity(0.3))
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
                    let url = URL(string: "https://random-quote-fact-joke-api.p.rapidapi.com/joke")!
                    var request = URLRequest (url: url)
                    request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                        "X-RapidAPI-Key")
                    
                    let (data, _) = try await URLSession.shared.data(for: request)
                    
                    print(String(data: data, encoding: .utf8))
                    let serverJoke = try JSONDecoder().decode(Randomjokes.self, from: data)
                    joke = serverJoke
                    
                } catch {
                    print("error \(error)")
                }
            }
            
        }

struct RandomJokes_Previews: PreviewProvider {
    static var previews: some View {
        RandomJokes()
    }
}
