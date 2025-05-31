//
//  AppStoreResponse.swift
//  Asset Management
//
//  Created by Supriyo Dey on 01/01/24.
//

import Foundation


struct AppStoreResponse: Codable {
    let resultCount: Int?
    let results: [AppStoreResult]?
}
struct AppStoreResult: Codable {
    let releaseNotes: String?
    let releaseDate: String?
    let version: String?
}
