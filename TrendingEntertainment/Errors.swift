//
//  Errors.swift
//  TrendingEntertainment
//
//  Created by Shakil Mahmud on 07.01.26.
//

import Foundation


enum ApiConfigError: Error, LocalizedError {
    case fileNotFound
    case dataLodingFailed(underlyingError: Error)
    case decodingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound:
            return "Api configuration file not found."
            case .dataLodingFailed(underlyingError: let error):
            return "Data loading failed. Underlying error: \(error.localizedDescription)"
        case .decodingFailed(underlyingError: let error):
            return "Decoding failed. Underlying error: \(error.localizedDescription)"
        }
    }
}


enum NetworkError: Error, LocalizedError {
    case badURLResponse(underlyingError: Error)
    case missingConfig
    case urlBuildFailed
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underlyingError: let error):
            return "Bad URL response. Underlying error: \(error.localizedDescription)"
        case .missingConfig:
            return "Missing API configuration."
        case .urlBuildFailed:
            return "Failed to build URL."
        }
    }
}
