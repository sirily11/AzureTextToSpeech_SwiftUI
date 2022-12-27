//
//  OpenTextFileCommand.swift
//  TextToSpeech
//
//  Created by Qiwei Li on 12/26/22.
//

import Foundation
import SwiftUI


struct SignoutCommand: Commands {
    let authenticationModel: AuthenticationModel
    let errorModel: ErrorModel
    
    var body: some Commands {
        CommandGroup(after: .newItem) {
            Button("Signout") {
               signOut()
            }
        }
    }
    
    func signOut() {
        authenticationModel.signOut()
    }
}
