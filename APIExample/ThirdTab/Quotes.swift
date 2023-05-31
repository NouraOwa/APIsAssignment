//
//  Quotes.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI
struct Quot: Codable, Identifiable {
    let id = UUID()
    let quote: Quote
    
}
struct Quote: Codable {
    let quote, author: String
}

struct Quotes: View {
    @State private var qoute = Quot(quote: Quote(quote: "", author: ""))
    var body: some View {
        ScrollView{
            VStack {
                Text("Today's Quote").font(.largeTitle).bold()
                    .padding()
                Text(qoute.quote.quote)
                    .frame(maxWidth: .infinity)
                    .font(.title)
                    .background (.purple.opacity(0.3))
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
            let url = URL(string: "https://random-quote-fact-joke-api.p.rapidapi.com/quote")!
            var request = URLRequest (url: url)
            request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                "X-RapidAPI-Key")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print(String(data: data, encoding: .utf8))
            let serverJoke = try JSONDecoder().decode(Quot.self, from: data)
            qoute = serverJoke
            
        } catch {
            print("error \(error)")
        }
    }
    
}

struct Quotes_Previews: PreviewProvider {
    static var previews: some View {
        Quotes()
    }
}
