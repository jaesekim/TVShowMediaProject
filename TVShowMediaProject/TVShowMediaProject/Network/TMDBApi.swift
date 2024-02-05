//
//  TMDBApi.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 2/1/24.
//

import Foundation
import Alamofire

enum TMDBApi {
    case trend
    case detail(movieId: Int)
    case recommend(movieId: Int)
    case casts(movieId: Int)
    
    var endPoint: URL {
        switch self {
        case .trend:
            return URL(string: "\(APIUrl.tmdb)/trending/tv/week?language=ko-KR")!
        case .detail(let movieId):
            return URL(string: "\(APIUrl.tmdb)/tv/\(movieId)?language=ko-KR")!
        case .recommend(let movieId):
            return URL(string: "\(APIUrl.tmdb)/tv/\(movieId)/recommendations?language=ko-KR")!
        case .casts(let movieId):
            return URL(string: "\(APIUrl.tmdb)/tv/\(movieId)/aggregate_credits?language=ko-KR")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: HTTPHeaders {
        return [
            "Authorization": APIKey.tmdbAPI
        ]
    }
}
