//
//  MovieDetailsHelper.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 06.07.24.
//

import Foundation

    enum MovieDetailsEndpoint: String {
        case details = "movie"
        
        var path: String {
            NetworkHelper.shared.requestUrl(url: self.rawValue)
        }
    }


