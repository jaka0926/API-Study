//
//  KakaoBook.swift
//  NetworkBasicUpgrade
//
//  Created by Jaka on 2024-06-11.
//

import Foundation

struct KakaoBook: Decodable {
    var documents: [BookDetail] //var
    let meta: Meta
}

struct BookDetail: Decodable {
    let title: String
    let contents: String
    let url: String //웹링크
    let thumbnail: String //이미지
    let authors: [String]
}

struct Meta: Decodable {
    let is_end: Bool
    let pageable_count: Int
    let total_count: Int
}
