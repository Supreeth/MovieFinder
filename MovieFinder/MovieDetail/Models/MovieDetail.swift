//
//  MovieDetail.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import Foundation

struct MovieDetail: Codable {
    let response: String
    let title: String
    let year: String
    let id: String
    let type: String
    let poster: String
    let runtime: String
    let released: String
    let genre: String
    let director: String
    let actors: String
    let writer: String
    let plot: String
    let awards: String
    let language: String
    let metascore: String
    let imdbRating: String
    let error: String?
    let rated: String?
    let votes: String?
    
    private enum CodingKeys: String, CodingKey {
        case response = "Response"
        case title = "Title"
        case year = "Year"
        case id = "imdbID"
        case type = "Type"
        case poster = "Poster"
        case runtime = "Runtime"
        case released = "Released"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case writer = "Writer"
        case plot = "Plot"
        case awards = "Awards"
        case language = "Language"
        case metascore = "Metascore"
        case rated = "Rated"
        case votes = "imdbVotes"
        case imdbRating
        case error = "Error"
    }
}
