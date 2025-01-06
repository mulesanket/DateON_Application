//
//  LoginScreenView.swift
//  DateON_App
//
//  Created by Sanket Mule on 02/01/25.
//

import SwiftUI

struct LoginScreenView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                // App Title
                Text("DateON")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .underline(true, color: Color.pink)
                
                // Subtitle
                Text("Login")
                    .font(.title2)
                    .foregroundColor(.gray)
                
                // Username and Password Fields
                VStack(spacing: 20) {
                    CustomTextField(placeholder: "Enter your username", text: $viewModel.enteredUsername)
                    CustomSecureField(placeholder: "Enter your password", text: $viewModel.enteredPassword)
                }
                .padding(.horizontal, 30)
                
                // Login Button
                Button(action: viewModel.validateLogin) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)
                
                // Error Message
                if viewModel.shouldShowErrorMessage {
                    Text("Invalid username or password")
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                Spacer()
                
                // Register Section
                VStack(spacing: 5) {
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    Button(action: {
                        print("Navigate to Register Screen")
                    }) {
                        Text("Register here")
                            .foregroundColor(.blue)
                            .fontWeight(.bold)
                    }
                }
                .padding(.top, 20)
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.isLoginSuccessful) {
                HomeScreenView()
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Custom Components for Text Fields

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField(placeholder, text: $text)
                .padding(.bottom, 5)
                .foregroundColor(.black)
            
            Divider()
                .background(Color.pink)
        }
    }
}

struct CustomSecureField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            SecureField(placeholder, text: $text)
                .padding(.bottom, 5)
                .foregroundColor(.black)
            
            Divider()
                .background(Color.pink)
        }
    }
}

// MARK: - Preview

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
