//
//  Book.swift
//  NetworkBasicUpgrade
//
//  Created by Jaka on 2024-06-10.
//

import Foundation

struct Book: Decodable {
    let total: Int
    let start: Int
    let display: Int
    let items: [BookInfo]
    
}

struct BookInfo: Decodable {
    let title: String
    let link: String
    let image: String
    let author: String
    let pubdate: String
    let description: String
}
