//
//  MovieListService.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import Foundation

public enum Type: String {
    case MOVIE = "movie"
    case SERIES = "series"
    case EPISODE = "episode"
}

class MovieListService: BaseService {
    
    public func search(for searchTerm: String,
                            type: Type,
                            page:Int = 1,
                            callback: @escaping(Search?, Error?) -> Void) {
        
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "s", value: searchTerm))
        queryItems.append(URLQueryItem(name: "type", value: type.rawValue))
        queryItems.append(URLQueryItem(name: "page", value: String(page)))
        queryItems.append(URLQueryItem(name: "apikey", value: Constants.Generic.apiKey))
        
        let networkManager = NetworkManager()
        networkManager.request(url: baseUrl,parameters: queryItems) { (data, response, status, error) in
            if let data = data, status == 200 {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(Search.self, from: data)
                    callback(result, nil)
                } catch let error {
                    callback(nil, error)
                }
            }else {
                callback(nil,MFError.invalidStatusCode(status))
            }
                                
        }
        
    }
}
