//
//  TMDBSessionManager.swift
//  TVShowMediaProject
//
//  Created by 김재석 on 2/5/24.
//

import Foundation

enum SesacError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class TMDBSessionManager {
    
    static let shared = TMDBSessionManager()
    
    func fetchTVTrending(
        completionHandler: @escaping (TVTrending?, SesacError?) -> Void
    ) {
        
        var url = URLRequest(url:TMDBApi.trend.endPoint)
        url.httpMethod = "GET"
        url.addValue(APIKey.tmdbAPI, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("네트워크 통신 실패")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {
                    print("데이터 없음")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    print("응답 에러")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                do {
                    print("!@$!@$!@$")
                    let result = try JSONDecoder().decode(TVTrending.self, from: data)
                    print("성공")
                    completionHandler(result, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
        }.resume()
    }
}
