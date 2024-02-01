//
//  TVCastings.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 1/31/24.
//

import Foundation

struct TVCastings: Decodable {
    let cast: [TVCastingsCasts]
}

struct TVCastingsCasts: Decodable {
    let name: String
    let profile: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case profile = "profile_path"
    }
}
