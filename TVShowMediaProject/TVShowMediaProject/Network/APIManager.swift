//
//  APIManager.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 1/30/24.
//

import Foundation
import Alamofire

// Singleton Pattern
class APIManager {
    
    static let shared = APIManager()
    
    func fetchWeekTrendTVShow(completionHandler: @escaping ([TVTrendingResults]) -> Void) {
        let url = "\(APIUrl.tmdb)/trending/tv/week?language=ko-KR"
        let headers: HTTPHeaders = [
            "Authorization": APIKey.tmdbAPI
        ]
        AF.request(
            url,
            method: .get,
            headers: headers
        ).responseDecodable(of: TVTrending.self) { request in
            switch request.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchTopRatedTVShow(completionHandler: @escaping ([TVTopRatedResults]) -> Void) {
        let url = "\(APIUrl.tmdb)/tv/top_rated?language=ko-KR"
        let headers: HTTPHeaders = [
            "Authorization": APIKey.tmdbAPI
        ]
        AF.request(
            url,
            method: .get,
            headers: headers
        ).responseDecodable(of: TVTopRated.self) { request in
            switch request.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchPopularTVShow(completionHandler: @escaping ([TVPopularResults]) -> Void) {
        let url = "\(APIUrl.tmdb)/tv/popular?language=ko-KR"
        let headers: HTTPHeaders = [
            "Authorization": APIKey.tmdbAPI
        ]
        AF.request(
            url,
            method: .get,
            headers: headers
        ).responseDecodable(of: TVPopular.self) { request in
            switch request.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchDetailTVShow(api: TMDBApi, completionHandler: @escaping (TVDetails) -> Void) {
        
        AF.request(
            api.endPoint,
            method: api.method,
            headers: api.headers
        ).responseDecodable(of: TVDetails.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchCastsTVShow(api: TMDBApi, completionHandler: @escaping ([TVCastingsCasts]) -> Void) {
        AF.request(
            api.endPoint,
            method: api.method,
            headers: api.headers
        ).responseDecodable(of: TVCastings.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.cast)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func fetchRecommendTVShow(api: TMDBApi, completionHandler: @escaping ([TVRecommendResults]) -> Void) {
        
        AF.request(
            api.endPoint,
            method: api.method,
            headers: api.headers
        ).responseDecodable(of: TVRecommend.self) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success.results)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
