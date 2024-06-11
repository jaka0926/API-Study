//
//  MovieStruct.swift
//  NetworkBasicUpgrade
//
//  Created by Jaka on 2024-06-12.
//

import Foundation

struct Movie: Decodable {
    var results: [MovieDetail]
}

struct MovieDetail: Decodable {
    let poster_path: String?
}


