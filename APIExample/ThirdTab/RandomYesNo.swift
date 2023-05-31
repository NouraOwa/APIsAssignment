//
//  RandomYesNo.swift
//  APIExample
//
//  Created by Noura Alowayid on 11/11/1444 AH.
//

import SwiftUI
struct YesNo: Codable, Identifiable{
    let answer: String
    var id: String {
        answer
    }
}
struct RandomYesNo: View {
        @State private var answer = YesNo(answer: "")
        var body: some View {
            ScrollView{
                VStack {
                    Text("Yes or No").font(.largeTitle).bold()
                    Text(answer.answer)
                        .frame (maxWidth: .infinity)
                        .foregroundColor (.black)
                        .font (.title2)
                        .padding(.all, 24)
                        .background (.gray.opacity(0.4))
                        .padding (.bottom, 30)
                    
                }
            }
                .task {
                    await loadData()
                }
            }
            
            func loadData( ) async {
                do {
                    let url = URL(string: "https://random-yes-no.p.rapidapi.com/")!
                    var request = URLRequest (url: url)
                    request.setValue("7a426fa361mshe5a681fa501fae6p1a95b9jsn65ca0a543894", forHTTPHeaderField:
                                        "X-RapidAPI-Key")
                    
                    let (data, _) = try await URLSession.shared.data(for: request)
                    
                    print(String(data: data, encoding: .utf8))
                    
                    let serverAnswer = try JSONDecoder().decode(YesNo.self, from: data)
                    answer = serverAnswer
                    
                } catch {
                    print("error \(error)")
                }
            }
    }
struct RandomYesNo_Previews: PreviewProvider {
    static var previews: some View {
        RandomYesNo()
    }
}
