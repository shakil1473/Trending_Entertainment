//
//  YoutubeSearchResponse.swift
//  TrendingEntertainment
//
//  Created by Shakil Mahmud on 08.01.26.
//

import Foundation


struct YoutubeSearchResponse: Codable {
    let items: [ItemProperties]?
}
struct ItemProperties: Codable {
    let id: IdProperties?
}

struct IdProperties: Codable {
    let videoId: String?
}
