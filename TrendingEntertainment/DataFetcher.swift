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
    let youtubeSearchURL = ApiConfig.shared?.youtubeSearchURL
    let youtubeAPIkey = ApiConfig.shared?.youtubeAPIKey
    
    //http://api.themoviedb.org/3/trending/movie/day?api_key=f4b10b4f90766b14aff60a70da1e3cf9
    func fetchTitles(for media:String, by type:String) async throws -> [Title] {
        let fetchTitleUrl = try buildURL(media: media, type: type)
        
        guard let fetchTitlesUrl = fetchTitleUrl else {
            throw NetworkError.urlBuildFailed
        }
        
        print(fetchTitlesUrl)
        
        var titles = try await fetchAndDecode(url: fetchTitlesUrl, type: TMDBAPIObject.self).results
        
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
            path = "3/\(type)/\(media)/day"
        } else if type == "top_rated" || type == "upcoming"  {
            path = "3/\(media)/\(type)"
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
    
    func fetchVideId(for title: String) async throws -> String {
        guard let baseSearchURL = youtubeSearchURL else {
            throw NetworkError.missingConfig
        }
        
        guard let searchAPIKey = youtubeAPIkey else {
            throw NetworkError.missingConfig
        }
        
        let trailerSearch = title + YoutubeURLStrings.space.rawValue + YoutubeURLStrings.trailer.rawValue
        
        guard let fetchVideoURL = URL(string: baseSearchURL)?.appending(queryItems: [
            URLQueryItem(name: YoutubeURLStrings.queryShorten.rawValue, value: trailerSearch),
            URLQueryItem(name: YoutubeURLStrings.key.rawValue, value: searchAPIKey)
        ]) else {
            throw NetworkError.urlBuildFailed
        }
        
        print(fetchVideoURL)
        return try await fetchAndDecode(url: fetchVideoURL, type: YoutubeSearchResponse.self).items?.first?.id?.videoId ?? ""
    }
    
    func fetchAndDecode<T: Decodable>(url: URL, type: T.Type) async throws -> T {
        let(data, urlResponse) = try await URLSession.shared.data(from: url)
        
        
        guard let response = urlResponse as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badURLResponse(underlyingError: NSError(
                domain: "DataGetcher",
                code: (urlResponse as? HTTPURLResponse)?.statusCode ?? -1,
                userInfo: [NSLocalizedDescriptionKey: "Invalid HTTP Response"]
            ))
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return  try decoder.decode(type, from: data)
    }
}
