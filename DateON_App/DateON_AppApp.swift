//
//  DateON_AppApp.swift
//  DateON_App
//
//  Created by Sanket Mule on 02/01/25.
//

import SwiftUI
import Firebase

@main
struct DateON_AppApp: App {
    init() {
            FirebaseApp.configure()
        }
    
    var body: some Scene {
        WindowGroup {
            LoginScreenView()
        }
    }
}
