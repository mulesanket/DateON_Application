import Foundation
import Firebase
import FirebaseAuth

class LoginViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var enteredUsername: String = ""
    @Published var enteredPassword: String = ""
    @Published var isLoginSuccessful: Bool = false
    @Published var shouldShowErrorMessage: Bool = false
    @Published var errorMessage: String = ""
    
    // MARK: - Public Methods
    func validateLogin() {
        let userName = enteredUsername.trimmingCharacters(in: .whitespacesAndNewlines)
        let userPassword = enteredPassword.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !userName.isEmpty, !userPassword.isEmpty else {
            errorMessage = "Username and password cannot be empty."
            shouldShowErrorMessage = true
            return
        }
        
        Auth.auth().signIn(withEmail: userName, password: userPassword) { authResult, error in
            if let error = error {
                if let errCode = AuthErrorCode(rawValue: error._code), errCode == .userNotFound {
                    self.errorMessage = "User not found. Please register first."
                } else {
                    self.errorMessage = "Login failed: \(error.localizedDescription)"
                }
                DispatchQueue.main.async {
                    self.shouldShowErrorMessage = true
                }
            } else {
                DispatchQueue.main.async {
                    self.isLoginSuccessful = true
                    self.shouldShowErrorMessage = false
                }
            }
        }
    }
}
