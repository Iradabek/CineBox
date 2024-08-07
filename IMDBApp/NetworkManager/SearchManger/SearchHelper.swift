//
//  SearchHelper.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 02.07.24.
//

import Foundation

enum SearchEndpoint: String {
    case search = "discover/movie"
    
    var path: String {
        NetworkHelper.shared.requestUrl(url: self.rawValue)
    }
}
