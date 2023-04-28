//
//  WikiResponse.swift
//  CheFiore
//
//  Created by 206568245 on 4/21/23.
//

import Foundation

struct WikiResponse: Codable {
    let batchcomplete: String
    let query: Query
}

struct Query: Codable {
    let redirects: [[String:String]]?
    let normalized: [[String:String]]?
    let pageids: [String]?
    let pages: [String: Page]
}

struct Page: Codable {
    let pageid: Int?
    let pageimage: String?
    let thumbnail: Thumbnail?
    let ns: Int?
    let title: String?
    let extract: String?
    let contentmodel: String?
    let pagelanguage: String?
    let pagelanguagehtmlcode: String?
    let touched: String?
    let lastrevid: Int?
    let length: Int?
}

struct Thumbnail: Codable {
    let height: Int
    let width: Int
    let source: String
}
