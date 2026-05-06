//
//  CatBreed.swift
//  CatFacts
//
//  Created by Louise Verbeke on 05/05/2026.
//

import Foundation

struct CatBreed: Codable, Identifiable {
    let id = UUID().uuidString
    var breed = ""
    var country = ""
    var origin = ""
    var coat = ""
    var pattern = ""
    
    enum CodingKeys: CodingKey {
        case breed, country, origin, coat, pattern
    }
}
