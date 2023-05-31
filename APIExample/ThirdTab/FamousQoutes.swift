//
//  FamousQoutes.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI
struct Famous: Codable {
    let quote: String
}

struct FamousQoutes: View {
    @State private var qute = Famous(quote: "")
    var body: some View {
        ScrollView{
            VStack {
                Text("Today's Famous Quote").font(.largeTitle).bold()
                    .padding()
                VStack{
                    Text(qute.quote)
                        .frame(maxWidth: .infinity)
                        .font(.title).bold()
                }.background (.yellow.opacity(0.3))
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
            let url = URL(string: "https://random-famous-quotes5.p.rapidapi.com/")!
            var request = URLRequest (url: url)
            request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                "X-RapidAPI-Key")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print(String(data: data, encoding: .utf8))
            let serverQuote = try JSONDecoder().decode(Famous.self, from: data)
            qute = serverQuote
            
        } catch {
            print("error \(error)")
        }
    }
    
}


struct FamousQoutes_Previews: PreviewProvider {
    static var previews: some View {
        FamousQoutes()
    }
}
