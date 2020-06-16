//
//  NetworkManager.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import Foundation

enum MIMETypes: String {
    case urlencoded = "application/x-www-form-urlencoded"
    case json = "application/json"
}

enum RequestType: String {
    case POST = "post"
    case GET = "get"
}

class NetworkManager {
    
    private let urlSessionConfig = URLSessionConfiguration.default
    private let cache = NSCache<NSString, NSData>()
    
    private struct authParameters {
        struct Keys {
            static let accept = "Accept"
            static let apiKey = "apikey"
        }
    }
    
    private static var sharedInstance: NetworkManager = {
        return NetworkManager()
    }()
    
    class func shared() -> NetworkManager {
        sharedInstance.configureSession()
        return sharedInstance
    }
    
    init() {
        configureSession()
    }
    
    
    //MARK: - Private
    
    private func configParameters(with parameters:[String:String]) -> Data? {
        guard parameters.count > 0 else {return nil}
        return  parameters.map {"\($0.key)=\($0.value)"}.joined(separator: "&").data(using: .utf8)
    }
    
    private func configureSession() {
        self.urlSessionConfig.httpAdditionalHeaders = [
            AnyHashable(authParameters.Keys.accept): MIMETypes.json.rawValue
        ]
    }
    
    //MARK: - Public
    
    public func request(url:String,
                         cachePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData,
                         httpMethod: RequestType = .GET,
                         headers:[String:String]? = nil,
                         body: [String:String]? = nil,
                         parameters: [URLQueryItem]?,
                         callback: @escaping (Data?, URLResponse?, Int?, Error?) -> Void) {
        
        if var urlComponent = URLComponents(string: url) {
           
            urlComponent.queryItems = parameters
            
            let session = URLSession(configuration: urlSessionConfig)
            
            if let url = urlComponent.url {
                       
                var request = URLRequest(url: url)
                request.cachePolicy = cachePolicy
                request.allHTTPHeaderFields = headers
                       
                if let body = body {
                    request.httpBody = configParameters(with: body)
                }
                request.httpMethod = httpMethod.rawValue
                       
                session.dataTask(with: request) { (data, response, error) in
                    let httpResponsStatusCode = (response as? HTTPURLResponse)?.statusCode
                    callback(data, response, httpResponsStatusCode, error)
                }.resume()
            }else{
                callback(nil, nil, nil, MFError.invalidURL)
            }
        }else{
            callback(nil, nil, nil, MFError.invalidURL)
        }
        
    }
    
    func getImage(url: String, callback: @escaping(Data?, Error?) -> Void){
        let cacheID = NSString(string: url)
        
        if let cachedData = cache.object(forKey: cacheID) {
            callback((cachedData as Data), nil)
        }else{
            if let url = URL(string: url) {
                let session = URLSession(configuration: urlSessionConfig)
                var request = URLRequest(url: url)
                request.cachePolicy = .returnCacheDataElseLoad
                request.httpMethod = RequestType.GET.rawValue
                session.dataTask(with: request) { (data, response, error) in
                    if let _data = data {
                        self.cache.setObject(_data as NSData, forKey: cacheID)
                        callback(data, nil)
                    }else{
                        callback(nil, error)
                    }
                }.resume()
            } else {
                callback(nil, MFError.invalidURL)
            }
        }
        
    }
}
