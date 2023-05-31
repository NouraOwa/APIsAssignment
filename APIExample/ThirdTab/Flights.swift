//
//  Flights.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI
struct Flight: Codable, Identifiable {
    let id = UUID()
    let airline: String
    let altitude: Int
    let arrival: String
    }
struct Flights: View {
    @State private var flight = [Flight]()
    var body: some View {
        ScrollView{
            VStack {
                Text("Flight").font(.largeTitle).bold()
                ForEach (flight) { item in
                    VStack {
                        Text(item.airline).font(.title2).bold()
                        Text(item.arrival)
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
            let url = URL(string: "https://flight-data4.p.rapidapi.com/get_airline_flights")!
            var request = URLRequest (url: url)
            request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                "X-RapidAPI-Key")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print(String(data: data, encoding: .utf8))
            
            let serverFlight = try JSONDecoder().decode([Flight].self, from: data)
            flight = serverFlight
            
        } catch {
            print("error \(error)")
        }
    }
}

struct Flights_Previews: PreviewProvider {
    static var previews: some View {
        Flights()
    }
}
