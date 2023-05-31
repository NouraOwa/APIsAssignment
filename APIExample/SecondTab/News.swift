//
//  News.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI
struct New: Codable, Identifiable {
    let id = UUID()
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable, Identifiable {
    let id = UUID()
    let title: String
    let url: String
}

struct News: View {
    @State private var news: New = New(status: "", totalResults: 0,articles:[ Article(title: "", url: "")])
    var body: some View {
        NavigationStack{
        ScrollView{
            VStack {
                    Text("Last News").font(.largeTitle).bold()
                VStack{
                    List(news.articles) { item in
                        Text(item.title)
                        Text(item.url)
                    }
                // ForEach (news) { item in
                VStack {
                    Text(news.status).font(.title2).bold()
                    NavigationLink(destination: ThirdTabBar()) {
                        Text("\(news.totalResults)")
                            .frame (maxWidth: .infinity)
                            .foregroundColor (.black)
                            .font (.title2)
                            .padding(.all, 24)
                            .background (.green.opacity(0.3))
                            .padding (.bottom, 30)
                    }
                        }.padding()
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
            let url = URL(string: "https://news-api14.p.rapidapi.com/top-headlines")!
            var request = URLRequest (url: url)
            request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                "X-RapidAPI-Key")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print(String(data: data, encoding: .utf8))
            let serverNews = try JSONDecoder().decode(New.self, from: data)
            news = serverNews
            
        } catch {
            print("error \(error)")
        }
    }
    
}
struct News_Previews: PreviewProvider {
    static var previews: some View {
        News()
    }
}
