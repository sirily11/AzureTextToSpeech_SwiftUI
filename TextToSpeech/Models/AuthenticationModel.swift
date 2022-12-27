//
//  KeychainModel.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import Foundation
import KeychainSwift
import AzureTextToSpeech

class AuthenticationModel: ObservableObject {
    @Published var key: String?
    @Published var region: AzureRegion?
    @Published var isLoading = false
    
    var isAuthenticated: Bool {
        get {
            if key != nil && region != nil {
                return true
            }
            return false
        }
    }
    
    let keychain: KeychainSwift
    let defaults: UserDefaults
    
    init(){
        keychain = KeychainSwift()
        defaults = UserDefaults.standard
        
        self.key = keychain.get("key")
        self.region = .init(rawValue: defaults.string(forKey: "region") ?? "")
    }
    
    func save(key: String, region: AzureRegion) {
        keychain.set(key, forKey: "key", withAccess: .accessibleWhenUnlocked)
        defaults.set(region.rawValue, forKey: "region")
        
        self.key = key
        self.region = region
    }
    
    func signOut() {
        self.key = nil
        self.region = nil
        defaults.removeObject(forKey: "region")
        keychain.delete("key")
    }
    
}
