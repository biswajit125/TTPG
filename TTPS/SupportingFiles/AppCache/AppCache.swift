//
//  AppCache.swift
//  Whetness
//
//  Created by Kamaljeet Punia on 22/09/20.
//  Copyright © 2020 Kamaljeet Punia. All rights reserved.
//

import UIKit


class AppCache: NSObject {
    
    static let shared = AppCache()
    
    // MARK: - CLASS LIFE CYCLE
    private override init() {
        super.init()
    }
    
    // MARK: - VARIABLES
//    var currentUser: LoginResponseModel? {
//        set {
//            if let newValue = newValue, let data = JSONEncoder().encodeToData(newValue) {
//                UserDefaults.standard.set(data, forKey: AppConstants.UserDefault.currentUser)
//            }
//        }
//        get {
//            if let data = UserDefaults.standard.data(forKey: AppConstants.UserDefault.currentUser) {
//                return JSONDecoder().decodeFromData(LoginResponseModel.self, from: data)
//            }
//            return nil
//        }
//    }
    
    var isWalkThrough = false
    
    func removeAllUserDefaults() {
        if let domain = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: domain)
        }
    }
}

extension JSONEncoder {
    func encodeToData<T: Encodable>(_ value: T) -> Data? {
        return try? self.encode(value)
    }
}

extension JSONDecoder {
    func decodeFromData<T: Decodable>(_ type: T.Type, from data: Data) -> T? {
        return try? self.decode(type, from: data)
    }
}
