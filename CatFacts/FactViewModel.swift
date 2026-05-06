//
//  FactViewModel.swift
//  CatFacts
//
//  Created by Louise Verbeke on 06/05/2026.
//

import Foundation

@Observable
@MainActor

class FactViewModel {
    struct Result: Codable {
        var fact: String
    }
    
    var fact: String = ""
    var urlString = "https://catfact.ninja/fact"
    
    var isLoading = false
    
    func getData() async {
        guard urlString != "" else { return }
        guard !isLoading else { return }
        
        isLoading = true
        print("🕸️ We are accessing the url \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not convert \(urlString) to url")
            isLoading = false
            return
        }
        
        do {
            let (data,_) = try await URLSession.shared.data(from:url)
            do {
                let result = try JSONDecoder().decode(Result.self, from: data)
                print("😎 JSON Decoded! Fact: \(result.fact).")
                self.fact = result.fact 
                isLoading = false
            } catch {
                isLoading = false
                print("😡 JSON ERROR: Could not properly decode JSON from \(urlString). \(error.localizedDescription)")
            }
        } catch {
            isLoading = false
            print("😡 ERROR: Could not access data from \(urlString).")
        }
    }
}
