//
//  ViewModel.swift
//  TrendingEntertainment
//
//  Created by Shakil Mahmud on 07.01.26.
//

import Foundation

@Observable
class ViewModel {
    enum FetchStatus {
        case notStarted
        case fetching
        case success
        case failed(underlyingError: Error)
    }
    
    private(set) var homeStatus: FetchStatus = .notStarted
    private let dataFetcher = DataFetcher()
    
    var trendingMovies: [Title] = []
    var trendingTVShows: [Title] = []
    
    var topRatedMovies: [Title] = []
    var topRatedTVShows: [Title] = []
    
    func getTitles() async {
        homeStatus = .fetching
        
        if trendingMovies.isEmpty {
            do {
                async let tMovies = dataFetcher.fetchTitles(for: "movie", by: "trending")
                async let tTVShows = dataFetcher.fetchTitles(for: "tv", by: "trending")
                
                async let tTopRatedMovies = dataFetcher.fetchTitles(for: "movie", by: "top_rated")
                async let tTopRatedTVShows = dataFetcher.fetchTitles(for: "tv", by: "top_rated")
                
                trendingMovies = try await tMovies
                trendingTVShows = try await tTVShows
                topRatedMovies = try await tTopRatedMovies
                topRatedTVShows = try await  tTopRatedTVShows
                
                homeStatus = .success
            } catch {
                print(error)
                homeStatus = .failed(underlyingError: error)
            }
        }
        else {
            homeStatus = .success
        }
    }
}
