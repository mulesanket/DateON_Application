//
//  RegisterNewUserView.swift
//  DateON_App
//
//  Created by Sanket Mule on 08/01/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore

struct RegisterNewUserView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String = ""
    @State private var isLoading: Bool = false
    @State private var isRegistered: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(Title.Register.rawValue)
                    .font(.title2)
                    .foregroundColor(.gray)
                
                VStack(spacing: 20) {
                    CustomFirstNameTextField(userFirstNameTextField: LoginScreenMessage.EnterFirstName.rawValue, userFirstNameText: $firstName)
                    CustomLastNameTextField(userLastNameTextField: LoginScreenMessage.EnterLastName.rawValue, userLastNameText: $lastName)
                    CustomEnterEmailTextField(userEnterEmailTextField: LoginScreenMessage.EnterEmail.rawValue, userEmailText: $email)
                    CustomEnterPasswordSecureField(userEnterPasswordTextField: LoginScreenMessage.EnterPassword.rawValue, userPasswordText: $password)
                }
                .padding(.horizontal, 30)
                
                Button(action: registerNewUser) {
                    Text(ButtonTitle.Register.rawValue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)
                
                Button(action: {
                    dismiss()
                }) {
                    Text(ButtonTitle.Cancel.rawValue)
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                }
            }
            .padding(.top, 50)
            Spacer()
            
        }
        .navigationBarHidden(true)
    }
    private func registerNewUser() {
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty, !password.isEmpty else {
            errorMessage = "All fields are mandatory."
            return
        }
        errorMessage = ""
        isLoading = true
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            isLoading = false
            if let error = error {
                errorMessage = "Registration failed: \(error.localizedDescription)"
                return
            }
            guard let userId = authResult?.user.uid else {
                errorMessage = "Failed to retrieve user ID."
                return
            }
            let db = Firestore.firestore()
            db.collection("users").document(userId).setData([
                "firstName": firstName,
                "lastName": lastName,
                "email": email
            ]) { error in
                if let error = error {
                    errorMessage = "Failed to save user data: \(error.localizedDescription)"
                } else {
                    DispatchQueue.main.async {
                        isRegistered = true
                        dismiss()
                    }
                }
            }
        }
    }
    
    struct CustomFirstNameTextField: View {
        var userFirstNameTextField: String
        @Binding var userFirstNameText: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                TextField(userFirstNameTextField, text: $userFirstNameText)
                    .autocapitalization(.words)
                    .autocorrectionDisabled()
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.bottom, 5)
                    .foregroundColor(.black)
                
                Divider()
                    .background(Color.pink)
            }
        }
    }
    
    struct CustomLastNameTextField: View {
        var userLastNameTextField: String
        @Binding var userLastNameText: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                TextField(userLastNameTextField, text: $userLastNameText)
                    .autocapitalization(.words)
                    .autocorrectionDisabled()
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding(.bottom, 5)
                    .foregroundColor(.black)
                
                Divider()
                    .background(Color.pink)
            }
        }
    }
    
    struct CustomEnterEmailTextField: View {
        var userEnterEmailTextField: String
        @Binding var userEmailText: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                TextField(userEnterEmailTextField, text: $userEmailText)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.bottom, 5)
                    .foregroundColor(.black)
                
                Divider()
                    .background(Color.pink)
            }
        }
    }
    
    struct CustomEnterPasswordSecureField: View {
        var userEnterPasswordTextField: String
        @Binding var userPasswordText: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                SecureField(userEnterPasswordTextField, text: $userPasswordText)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.bottom, 5)
                    .foregroundColor(.black)
                
                Divider()
                    .background(Color.pink)
            }
        }
    }
}

// MARK: - Preview
struct RegisterNewUserView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterNewUserView()
    }
}
