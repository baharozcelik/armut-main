//
//  HomeResponse.swift
//  armut-test
//
//

import Foundation

struct Home: Codable {
    let trending: [Service]?
    let other: [Service]?
    let posts: [Post]?
}
