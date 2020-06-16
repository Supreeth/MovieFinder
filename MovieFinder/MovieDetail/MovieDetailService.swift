//
//  MovieDetailService.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import Foundation

class MovieDetailService: BaseService {
    
    func getMovieDetail(with imdbID: String,
                  callback: @escaping(MovieDetail?, Error?) -> Void){
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "i", value: imdbID))
        queryItems.append(URLQueryItem(name: "apikey", value: Constants.Generic.apiKey))
        
        let networkManager = NetworkManager()
        networkManager.request(url:baseUrl, parameters: queryItems) {
            (data, response, status, error)  in
            if let _data = data, status == 200 {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(MovieDetail.self, from: _data)
                    callback(result, nil)
                } catch let error {
                    callback(nil, error)
                }
            }else{
                callback(nil, MFError.invalidStatusCode(status))
            }
        }
    }
}
