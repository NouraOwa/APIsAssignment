//
//  RandomWord.swift
//  APIExample
//
//  Created by Noura Alowayid on 10/11/1444 AH.
//

import SwiftUI
struct Word: Codable, Identifiable{
    let word: String
    var id: String {
        word
    }
}

struct RandomWord: View {
    @State private var word = Word(word: "")
    var body: some View {
        ScrollView{
            
            VStack {
                Text(word.word)
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
                let url = URL(string: "https://api.api-ninjas.com/v1/randomword")!
                var request = URLRequest (url: url)
                request.setValue("r5KH4fSoLgFaSwo69uUsxw==FDkbnI4CgVWATJp4", forHTTPHeaderField:
                                    "X-Api-Key")
                
                let (data, _) = try await URLSession.shared.data(for: request)
                
                print(String(data: data, encoding: .utf8))
                
                let serverWord = try JSONDecoder().decode(Word.self, from: data)
                word = serverWord
                
            } catch {
                print("error \(error)")
            }
        }
}

struct RandomWord_Previews: PreviewProvider {
    static var previews: some View {
        RandomWord()
    }
}
