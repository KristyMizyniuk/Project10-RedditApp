//
//  RedditModel.swift
//  RedditApp
//
//  Created by Христина Мізинюк on 23.04.2023.
//

import Foundation

// MARK: - Reddit
struct Reddit: Codable {
    let data: RedditData
}

// MARK: - RedditData
struct RedditData: Codable {
    let children: [Page]
    
    enum CodingKeys: String, CodingKey {
        case children
    }
}

// MARK: - Page
struct Page: Codable {
    let data: PageData
}

// MARK: - PageData
struct PageData: Codable {
    let title: String
    let subredditNamePrefixed: String
    let numComments: Int
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case subredditNamePrefixed = "subreddit_name_prefixed"
        case url
        case numComments = "num_comments"
    }
}
