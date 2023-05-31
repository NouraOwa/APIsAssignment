//
//  IMDpMovies.swift
//  APIExample
//
//  Created by Noura Alowayid on 10/11/1444 AH.
//

import SwiftUI

struct Movie: Decodable, Identifiable {
    let id: String
    let rank: Int
    let title: String
    let rating: String
    let year: Int
    let description: String
}
struct IMDpMovies: View {
    @State private var movie = [Movie]()
    
    //    [
    //        Movies(rank: 1,
    //               title: "The Shawshank Redemption",
    //               rating: 9.3,
    //               id: "top1",
    //               year: 1994,
    //               description: "Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.")
    //    ]
    
    var body: some View {
        ScrollView{
            VStack {
                Text("The Top 100 Movies").font(.largeTitle).bold()
                ForEach (movie) { item in
                    VStack{
                        ZStack(){
                            Rectangle()
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color.gray.opacity(0.1))
                                .cornerRadius(5)
                            VStack(alignment: .leading, spacing: 4){
                                HStack(spacing: 0){
                                    Text(item.id).bold().padding(.trailing,75)
                                    
                                    Text(item.title).bold()
                                    
                                }
                                Text("\(item.rating)").font(.caption)
                                Text(item.description).font(.subheadline).padding(5).background(Color.yellow.opacity(0.2)) .border(Color.blue.opacity(0.2), width: 3)
                                
                            }
                        }
                    }.padding()
                }
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData( ) async {
        do {
            //                try! await Task.sleep(nanoseconds: 3_000_000_000)
            let url = URL(string: "https://imdb-top-100-movies.p.rapidapi.com/")!
            var request = URLRequest (url: url)
            request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                "X-RapidAPI-Key")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print(String(data: data, encoding: .utf8))
            let serverMovies = try JSONDecoder().decode([Movie].self, from: data)
            movie = serverMovies
            
        } catch {
            print("error \(error)")
        }
    }
    
}

struct IMDpMovies_Previews: PreviewProvider {
    static var previews: some View {
        IMDpMovies()
    }
}

