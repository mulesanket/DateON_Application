//
//  LoginViewModel.swift
//  DateON_App
//
//  Created by Sanket Mule on 02/01/25.
//

import Foundation

class LoginViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var enteredUsername: String = ""       // User-entered username
    @Published var enteredPassword: String = ""       // User-entered password
    @Published var isLoginSuccessful: Bool = false    // Tracks login success
    @Published var shouldShowErrorMessage: Bool = false // Tracks error message visibility
    
    // MARK: - Private Properties
    private var userCredentials: [LoginCredentialsModel] = [] // Valid credentials loaded from JSON
    
    // MARK: - Initializer
    init() {
        loadUserCredentialsFromJSON()
    }
    
    // MARK: - Public Methods
    /// Validates the entered username and password against the loaded credentials
    func validateLogin() {
        // Check if username and password match
        if userCredentials.contains(where: { $0.username == enteredUsername && $0.password == enteredPassword }) {
            isLoginSuccessful = true
            shouldShowErrorMessage = false
        } else {
            isLoginSuccessful = false
            shouldShowErrorMessage = true
        }
    }
    
    // MARK: - Private Methods
    /// Loads credentials from the `logincredential.json` file in the app bundle
    private func loadUserCredentialsFromJSON() {
        // Locate the JSON file in the app bundle
        guard let jsonFileURL = Bundle.main.url(forResource: "LoginCredential", withExtension: "json") else {
            print("Error: Could not find logincredential.json in the app bundle.")
            return
        }
        
        do {
            // Load and decode JSON data
            let jsonData = try Data(contentsOf: jsonFileURL)
            userCredentials = try JSONDecoder().decode([LoginCredentialsModel].self, from: jsonData)
        } catch {
            // Log error if loading or parsing fails
            print("Error: Failed to load or parse logincredential.json. \(error.localizedDescription)")
        }
    }
}
