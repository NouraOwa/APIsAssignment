//
//  CoinFlip.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI
struct Coin: Codable, Identifiable{
    let outcome: String
    var id: String {
        outcome
    }
}

struct CoinFlip: View {
        @State private var outcome = Coin(outcome: "")
        var body: some View {
            ScrollView{
                VStack {
                    Text("Heads or Tails?").font(.largeTitle).bold()
                    Text(outcome.outcome)
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
                    let url = URL(string: "https://coin-flip1.p.rapidapi.com/headstails")!
                    var request = URLRequest (url: url)
                    request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                        "X-RapidAPI-Key")
                    
                    let (data, _) = try await URLSession.shared.data(for: request)
                    
                    print(String(data: data, encoding: .utf8))
                    
                    let serverCoin = try JSONDecoder().decode(Coin.self, from: data)
                    outcome = serverCoin
                    
                } catch {
                    print("error \(error)")
                }
            }
    }


struct CoinFlip_Previews: PreviewProvider {
    static var previews: some View {
        CoinFlip()
    }
}
