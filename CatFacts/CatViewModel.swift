//
//  CatViewModel.swift
//  CatFacts
//
//  Created by Louise Verbeke on 05/05/2026.
//

import Foundation

@Observable
@MainActor

class CatViewModel {
    struct Result: Codable {
        var data: [CatBreed]
        var total: Int
        var next_page_url: String?
    }
    
    var catBreeds: [CatBreed] = []
    var urlString = "https://catfact.ninja/breeds"
    var total = 0
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
                print("😎 JSON Decoded! \(result.data.count) breeds downloaded.")
                catBreeds += result.data
                total = result.total
                urlString = result.next_page_url ?? ""
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
    
    func loadNextIfNeeded(catBreed: CatBreed) async {
        guard let lastBreed = catBreeds.last else { return }
        if catBreed.id == lastBreed.id {
            print("*** Time to Get More Data ***")
            await getData()
        }
    }
    
    func loadAll() async {
        guard urlString != "" else { return }
        await getData()
        await loadAll()
    }
}
