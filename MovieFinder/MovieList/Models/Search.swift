//
//  Search.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import Foundation

struct Search: Codable {
    let movies: [Movie]?
    let totalResults: String?
    let response: String
    let error: String?
    
    private enum CodingKeys: String, CodingKey {
        case movies = "Search"
        case totalResults
        case response = "Response"
        case error = "Error"
    }
}
