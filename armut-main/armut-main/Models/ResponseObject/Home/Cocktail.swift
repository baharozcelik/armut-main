//
//  Home.swift
//  armut-main
//
//  Created by Bahar on 10.02.2021.
//


import Foundation

struct Cocktail: Codable {
    
    let title, category: String
    let imageURL: String
    let link: String

    
    enum CodingKeys: String, CodingKey {
        case title, category
        case imageURL = "image_url"
        case link
    }
}

extension Cocktail {
    
    init?(data: Data) {
        
        guard let me = try? JSONDecoder().decode(Cocktail.self, from: data)
            
            else {
                
                return nil
        }
        self = me
    }
}
