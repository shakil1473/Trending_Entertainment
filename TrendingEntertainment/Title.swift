//
//  Title.swift
//  TrendingEntertainment
//
//  Created by Shakil Mahmud on 07.01.26.
//

import Foundation

struct APIObject: Decodable {
    var results: [Title] = []
}
struct Title: Decodable, Identifiable {
    var id: Int
    var title: String?
    var name: String?
    var overview: String?
    var posterPath: String?
    
    static var previewTitles = [
        Title(id: 1, title: "The Rookie", name: "The Rookie", overview: "A tv series. Available in Amazon prime", posterPath: Constans.testTitleURL1),
        Title(id: 2, title: "Fallout: New Vegas", name: "Fallout: New Vegas", overview: "A movie I don't have any info on", posterPath: Constans.testTitleURL2),
        Title(id: 3, title: "Predator Badlands", name: "Predator Badlands", overview: "Never heard about the movie", posterPath: Constans.testTitleURL3),
        Title(id: 4, title: "The Darwin Incident", name: "The Darwin Incident", overview: "Looks like the movie is about Darwin theory", posterPath: Constans.testTitleURL4),
        Title(id: 5, title: "Stranger Things", name: "Stranger Things", overview: "A netflix tv series", posterPath: Constans.testTitleURL5)
    ]
}
