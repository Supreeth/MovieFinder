//
//  Collection.swift
//  MovieFinder
//
//  Created by Supreethd on 14/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
