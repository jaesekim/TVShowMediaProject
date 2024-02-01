//
//  TVDetails.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 1/31/24.
//

import Foundation

struct TVDetails:Decodable {
    let id: Int
    let name: String
    let overview: String
    let poster: String?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case overview
        case poster = "poster_path"
    }
}
