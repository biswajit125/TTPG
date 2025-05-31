//
//  UserDefaultsManager.swift
//  E-Wallet
//
//  Created by Prashant Kumar on 07/02/24.
//

import Foundation
class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    
    private init() {}
    
    enum UserDefaultsKey: String {
        case loginToken
        case username
        case eventname
        case functionname
        case vendorname
        case permissionsAndroid  // Add key for permissionsAndroid
        case verifyOTPResponse
        
        
        case guestId
        case eventId
        case token
    }
    
    // Save value to UserDefaults
    func saveValue(_ value: Any, forKey key: UserDefaultsKey) {
        userDefaults.set(value, forKey: key.rawValue)
    }
    
    // Save permissionsAndroid (array of Permissions)
//    func savePermissionsAndroid(_ permissions: [Permissions]) {
//        do {
//            let encoder = JSONEncoder()
//            let data = try encoder.encode(permissions)
//            saveValue(data, forKey: .permissionsAndroid)
//        } catch {
//            print("Failed to save permissionsAndroid: \(error)")
//        }
//    }
    
    // Get value from UserDefaults
    func getValue(forKey key: UserDefaultsKey) -> Any? {
        return userDefaults.value(forKey: key.rawValue)
    }
    
    // Remove value from UserDefaults
    func removeValue(forKey key: UserDefaultsKey) {
        userDefaults.removeObject(forKey: key.rawValue)
    }
    func saveVerifyOTPResponse(_ model: VerifyOTPResponseModel) {
        do {
            let data = try JSONEncoder().encode(model)
            saveValue(data, forKey: .verifyOTPResponse) // ✅ Use correct key
        } catch {
            print("Failed to encode VerifyOTPResponseModel: \(error)")
        }
    }
    
    func getVerifyOTPResponse() -> VerifyOTPResponseModel? {
        guard let data = getValue(forKey: .verifyOTPResponse) as? Data else {
            return nil
        }
        do {
            let model = try JSONDecoder().decode(VerifyOTPResponseModel.self, from: data)
            return model
        } catch {
            print("Failed to decode VerifyOTPResponseModel: \(error)")
            return nil
        }
    }
    // Retrieve permissionsAndroid
//    func getPermissionsAndroid() -> [Permissions]? {
//        if let data = getValue(forKey: .permissionsAndroid) as? Data {
//            let decoder = JSONDecoder()
//            do {
//                let permissions = try decoder.decode([Permissions].self, from: data)
//                return permissions
//            } catch {
//                print("Failed to decode permissionsAndroid: \(error)")
//            }
//        }
//        return nil
//    }
}

