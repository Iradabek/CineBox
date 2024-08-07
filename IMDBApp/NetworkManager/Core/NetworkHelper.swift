//
//  NetworkHelper.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 01.07.24.
//

import Foundation

class NetworkHelper {
    static let shared = NetworkHelper()
        
    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "e2253416fac0cd2476291eb33c92beb7"
    private let imageBasePath = "https://image.tmdb.org/t/p/original/"
    
    func requestUrl(url: String) -> String {
        baseURL + url + "?api_key=\(apiKey)"
    }
    
    func getImagePath(url: String) -> String {
        imageBasePath + url
    }
}
