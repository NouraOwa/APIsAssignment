//
//  Reciepe.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI
struct Recipe: Codable, Identifiable {
    let id, name: String
    let tags: [String]
    let description: String
    let prepareTime, cookTime: Int
    let ingredients: [Ingredient]
}
struct Ingredient: Codable {
    let name: String
}


struct Reciepe: View {
    @State private var food = [Recipe]()
    var body: some View {
        ScrollView{
            VStack {
                Text("What for dinner?").font(.largeTitle).bold()
                ForEach (food) { item in
                    VStack {
                        Text(item.name).font(.title2).bold()
                        Text(item.description)
                            .frame (maxWidth: .infinity)
                            .foregroundColor (.black)
                            .font (.title2)
                            .padding(.all, 24)
                            .background (.green.opacity(0.3))
                            .padding (.bottom, 30)
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
            let url = URL(string: "https://low-carb-recipes.p.rapidapi.com/search?name=cake&tags=keto%3Bdairy-free&includeIngredients=egg%3Bbutter&excludeIngredients=cinnamon&maxPrepareTime=10&maxCookTime=20&maxCalories=500&maxNetCarbs=5&maxSugar=3&maxAddedSugar=0&limit=10")!
            var request = URLRequest (url: url)
            request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                "X-RapidAPI-Key")
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            print(String(data: data, encoding: .utf8))
            let serverJoke = try JSONDecoder().decode([Recipe].self, from: data)
            food = serverJoke
            
        } catch {
            print("error \(error)")
        }
    }
    
}


struct Reciepe_Previews: PreviewProvider {
    static var previews: some View {
        Reciepe()
    }
}
