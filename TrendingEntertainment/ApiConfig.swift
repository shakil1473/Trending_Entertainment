//
//  ApiConfig.swift
//  TrendingEntertainment
//
//  Created by Shakil Mahmud on 07.01.26.
//

import Foundation

struct ApiConfig: Decodable {
    let tmdbBaseURL: String
    let tmdbAPIKey: String
    let youtubeBaseURL: String
    let youtubeAPIKey: String
    let youtubeSearchURL: String
    
    static let shared: ApiConfig? = {
        do {
            return try loadConfig()
        } catch {
            print("Failed to load Api config: \(error.localizedDescription)")
            return nil
        }
    }()
    
    private static func loadConfig() throws -> ApiConfig {
        guard let url = Bundle.main.url(forResource: "ApiConfig", withExtension: "json") else {
            throw ApiConfigError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(ApiConfig.self, from: data)
        } catch {
            throw ApiConfigError.decodingFailed(underlyingError: error)
        } catch {
            throw ApiConfigError.dataLodingFailed(underlyingError: error)
        }
    }
}
