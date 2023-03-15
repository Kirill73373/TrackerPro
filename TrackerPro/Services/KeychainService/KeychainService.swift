//
//  KeychainService.swift
//  TrackerPro
//
//  Created by Кирилл Блохин on 15.03.2023.
//

import Foundation

final class KeychainService {
    
    //MARK: - Type
    
    enum KeychainStorageError: Error {
        case duplicate
        case unknow(OSStatus)
    }
    
    enum KeychainStorageType: String {
        case password = "password"
    }
    
    //MARK: - Private property
    
    private let serviceName = "KeeptyCryptoStorage"
    
    //MARK: - Public Methods
    
    func tryEncryptValue(_ type: KeychainStorageType, value: String) {
        do {
            try encryptValue(type, value: value)
        } catch {
            print("ERROR tryEncryptValue")
        }
    }
    
    func tryGetDecipheredValue(_ type: KeychainStorageType) -> String {
        do {
            return try String(decoding: getDecipheredValue(type) ?? Data(), as: UTF8.self)
        } catch {
            print("ERROR tryGetDecipheredValue")
        }
        return String()
    }
    
    func tryDeleteValue(_ type: KeychainStorageType) {
        do {
            try deleteValue(.password)
        } catch {
            print("ERROR deleteValue")
        }
    }
    
    func tryUpdateValue(_ type: KeychainStorageType, value: String) {
        do {
            try updateValue(type, value: value)
        } catch {
            print("ERROR tryUpdateValue")
        }
    }
    
    //MARK: - Private Methods
    
    // Write value to storage
    
    private func encryptValue(_ type: KeychainStorageType, value: String) throws {
        let valueData = value.data(using: .utf8) ?? Data()
        let query: [String : AnyObject] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : serviceName as AnyObject,
            kSecAttrAccount as String : type.rawValue as AnyObject,
            kSecValueData as String : valueData as AnyObject
        ]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status != errSecDuplicateItem else {
            throw KeychainStorageError.duplicate
        }
        guard status == errSecSuccess else {
            throw KeychainStorageError.unknow(status)
        }
    }
    
    // Removing a value from storage
    
    private func deleteValue(_ type: KeychainStorageType) throws {
        let query: [String : AnyObject] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : serviceName as AnyObject,
            kSecAttrAccount as String : type.rawValue as AnyObject,
            kSecReturnData as String : kCFBooleanTrue
        ]
        let _ = SecItemDelete(query as CFDictionary)
    }
    
    // Update value from storage
    
    private func updateValue(_ type: KeychainStorageType, value: String) throws {
        let valueData = value.data(using: .utf8) ?? Data()
        let query: [String : AnyObject] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : serviceName as AnyObject,
            kSecAttrAccount as String : type.rawValue as AnyObject,
        ]
        let updateValue: [String : AnyObject] = [
            kSecValueData as String : valueData as AnyObject
        ]
        let _ = SecItemUpdate(query as CFDictionary, updateValue as CFDictionary)
    }
    
    // Getting a value from storage
    
    private func getDecipheredValue(_ type: KeychainStorageType) throws -> Data? {
        let query: [String : AnyObject] = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrService as String : serviceName as AnyObject,
            kSecAttrAccount as String : type.rawValue as AnyObject,
            kSecReturnData as String : kCFBooleanTrue,
            kSecMatchLimit as String : kSecMatchLimitOne
        ]
        var result: AnyObject?
        let _ = SecItemCopyMatching(query as CFDictionary, &result)
        return result as? Data
    }
    
}

