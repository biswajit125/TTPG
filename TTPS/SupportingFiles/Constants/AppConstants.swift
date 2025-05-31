//
//  AppConstants.swift
//  Whetness
//
//  Created by Kamaljeet Punia on 22/09/20.
//  Copyright © 2020 Kamaljeet Punia. All rights reserved.
//

import Foundation

enum APIEnvironment{
    case development
    case production
    case staging
}

struct AppConstants {
    //App environment
    static let environment: APIEnvironment = .development
    
    struct APIHeaders {
        
        static let header: [String: Any] = [
            "accept": "*/*"
           
        ]
        
//        static let headers: [String: String] = [
//            "accept": "*/*",
//        ]
        
        static let headers: [String: String] = [
            "Content-Type": "application/json",
            // "appversion": "1",
            "Accept": "application/json"
        ]
        // let boundary = "Boundary-\(UUID().uuidString)"
        static let multipartHeaders: [String: Any] = [
            
            "Content-Type": "multipart/form-data;boundary=\(UUID().uuidString)",
            //"appversion": "1",
            "Accept": "multipart/form-data",
            
        ]
        static let headersWithAuthToken: [String: Any] = {
            return [
                "Content-Type": "application/json",
                "Accept": "application/json",
                // "appversion": "1"
            ]
        }()
    }
    
    //Base url
    struct Urls {
        
        static var apiBaseUrl: String {
            switch AppConstants.environment {
            case .development:
               // return "http://192.168.13.10:8080/mulligan-golf/"
              //  return "http://45.64.222.18:8080/mulligan-golf-v1/"
               return "http://45.64.222.18:8083/mulligan-golf/"
            case .production:
                return "https://memberdating.itechnolabs.tech/api/"
            case .staging:
                return "http://45.64.222.18:8080/mulligan-golf-v1/"
            }
        }
    }

    //User default keys
    struct UserDefault {
        static let currentUser = "currentUser"
    }
}

