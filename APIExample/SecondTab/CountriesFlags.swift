//
//  CountriesFlags.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI
struct Datum: Codable, Identifiable {
    let id = UUID()
    let name, iso2, iso3, unicodeFlag: String
}
struct Flag: Codable {
    let data: [Datum]
}
struct CountriesFlags: View {
    @State private var flags: Flag = Flag(data: [
           Datum(name: "United States", iso2: "US", iso3: "USA", unicodeFlag: "\u{1F1FA}\u{1F1F8}")])
    var body: some View {
        VStack{
            Text("Countries").font(.largeTitle).bold()
            List(flags.data) { datum in
                Text(datum.name)
                Image(systemName: datum.unicodeFlag)
            }
        }
        .task {
            await loadData()
        }
    }
    func loadData( ) async {
        do {
            let url = URL(string: "https://countriesnow.space/api/v0.1/countries/flag/unicode")!
            let (data, _) = try! await URLSession.shared.data(from: url)
            let serverData = try JSONDecoder().decode(Flag.self, from: data)
            flags = serverData
        } catch {
            print("error \(error)")
        }
    }
}

struct CountriesFlags_Previews: PreviewProvider {
    static var previews: some View {
        CountriesFlags()
    }
}
