//
//  TVRecommend.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 1/31/24.
//

import Foundation

struct TVRecommend: Decodable {
    let results: [TVRecommendResults]
}

struct TVRecommendResults: Decodable {
    let name: String
    let poster: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case poster = "poster_path"
    }
}
