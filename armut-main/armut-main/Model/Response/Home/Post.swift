//
//  Post.swift
//  armut-test
//
//  Created by Amer Atia on 12.02.2021.
//

import Foundation

struct Post: Codable {
    let title, category: String?
    let imageURL: String?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case title, category
        case imageURL = "image_url"
        case link
    }
}
