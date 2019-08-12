//
//  MovieListResponseModel.swift
//  Movie Time Demo
//
//  Created by Mark Anthony Degamo on 12/08/2019.
//  Copyright © 2019 Mark Anthony Degamo. All rights reserved.
//

import Foundation

struct MovieListResponseModel: Decodable {
    let resultCount: Int
    let results: [MovieResponseModel]
}
