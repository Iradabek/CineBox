//
//  HomeHelper.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 01.07.24.
//

import Foundation

enum MovieCategory {
    case nowPlaying
    case popular
    case trending
    case topRated
    case upcoming
}

enum HomeEndpoint: String {
    case genre = "genre/movie/list"
    case popular = "movie/popular"
    case nowPlaying = "movie/now_playing"
    case trending = "trending/movie/day"
    case topRated = "movie/top_rated"
    case upcoming = "movie/upcoming"

    var path: String {
        NetworkHelper.shared.requestUrl(url: self.rawValue)
    }
}

