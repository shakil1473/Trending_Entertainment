//
//  DataFetcher.swift
//  TrendingEntertainment
//
//  Created by Shakil Mahmud on 07.01.26.
//

import Foundation

struct DataFetcher {
    
    let tmdbBaseURL = ApiConfig.shared?.tmdbBaseURL
    let tmdbAPIKey = ApiConfig.shared?.tmdbAPIKey
    
    //http://api.themoviedb.org/3/trending/movie/day?api_key=f4b10b4f90766b14aff60a70da1e3cf9
    func fetchTitles(for media:String, by type:String) async throws -> [Title] {
        let fetchTitleUrl = try buildURL(media: media, type: type)
        
        guard let fetchTitlesUrl = fetchTitleUrl else {
            throw NetworkError.urlBuildFailed
        }
        
        print(fetchTitlesUrl)
        
        let(data, urlResponse) = try await URLSession.shared.data(from: fetchTitlesUrl)
        
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badURLResponse(underlyingError: NSError(
                domain: "DataGetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]
            ))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var titles = try decoder.decode(APIObject.self, from: data).results
        Constans.addPosterPath(to: &titles)
        return titles
    }
    
    private func buildURL(media:String, type:String) throws -> URL? {
        guard let baseUrl = tmdbBaseURL else {
            throw NetworkError.missingConfig
        }
        
        guard let apiKey = tmdbAPIKey else {
            throw NetworkError.missingConfig
        }
        
        var path:String
        
        if type == "trending" {
            path = "3/trending/\(media)/day"
        } else if type == "top_rated" {
            path = "3/\(media)/top_rated"
        } else {
            throw NetworkError.urlBuildFailed
        }
        
        guard let url = URL(string: baseUrl)?
            .appending(path: path)
            .appending(queryItems: [
                URLQueryItem(name: "api_key", value: apiKey)
            ]) else {
            throw NetworkError.urlBuildFailed
        }
        
        return url
    }
}
