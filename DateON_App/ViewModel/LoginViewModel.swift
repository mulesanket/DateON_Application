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
        let trimmedUsername = enteredUsername.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPassword = enteredPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if userCredentials.contains(where: { $0.username == trimmedUsername && $0.password == trimmedPassword }) {
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
        guard let jsonFileURL = Bundle.main.url(forResource: "LoginCredentials", withExtension: "json") else {
            print("Error: Could not find logincredential.json in the app bundle.")
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: jsonFileURL)
            userCredentials = try JSONDecoder().decode([LoginCredentialsModel].self, from: jsonData)
        } catch {
            print("Error: Failed to load or parse logincredential.json. \(error.localizedDescription)")
        }
    }
}
