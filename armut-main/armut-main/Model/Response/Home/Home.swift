//
//  HomeResponse.swift
//  armut-main
//
//  Created by Bahar on 12.02.2021.
//

import Foundation

struct Home: Codable {
    let trending: [Service]?
    let other: [Service]?
    let posts: [Post]?
}
