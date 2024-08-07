//
//  NetworkError.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import Foundation

enum NetworkError: String, Error {
       case invalidURL = "Invalid URL"
       case invalidData = "Invalid Data"
       case generalError = "General Error"
}
