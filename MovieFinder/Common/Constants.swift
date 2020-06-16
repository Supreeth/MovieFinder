//
//  Constants.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Nibs {
        static let listCollectionCell = "MovieListCollectionViewCell"
        static let movieTitleTableViewCell = "MovieTitleTableViewCell"
        static let synopsisTableViewCell = "SynopsisTableViewCell"
        static let castTableViewCell = "CastTableViewCell"
    }
    
    struct Generic {
        static let apiKey = "b9bd48a6"
        static let error = "Something went wrong, please try again"
    }
    
    struct Segue {
        static let pushToDetail = "pushToDetail"
    }
    
    struct List {
        static let title = "Film List"
        static let search = "Search..."
        static let hint = "Type a movie name, such as Marvel"
        static let listFetchError = "Type a movie name, such as Marvel"
        static let searchFailed = "SearchFailed!"
        static let footerViewX = 40.0
        static let minCharsForSearch = 2
        static let cellPadding = 50
        static let cellHeight = 250
    }
    
    struct Details {
        static let title = "Movie Details"
        static let estimatedRowHeight = 360
    }
}
