//
//  NewsFeedModel.swift
//  SwiftUINewsApplication
//
//  Created by Pradeep's Macbook on 15/11/21.
//

import Foundation

struct NewsResponseAPI: Codable {
    var status: String?
    var articles: [NewsListItem]?
}

struct NewsListItem: Codable,Identifiable {
    var id = UUID()
    var author: String?
    var title: String?
    var urlToImage: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey{
        case author
        case title
        case urlToImage
        case url
    }
}

