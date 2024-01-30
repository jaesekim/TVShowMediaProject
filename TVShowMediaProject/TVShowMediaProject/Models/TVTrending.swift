//
//  TVTrending.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 1/30/24.
//

import Foundation

struct TVTrending: Decodable {
    let results: [TVTrendingResults]
}

struct TVTrendingResults: Decodable {
    let id: Int
    let name: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case poster = "poster_path"
    }
}
