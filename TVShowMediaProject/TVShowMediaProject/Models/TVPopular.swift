//
//  TVPopular.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 1/30/24.
//

import Foundation

struct TVPopular: Decodable {
    let page: Int
    let results: [TVPopularResults]
}

struct TVPopularResults: Decodable {
    let id: Int
    let name: String
    var poster: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case poster = "poster_path"
    }
}
