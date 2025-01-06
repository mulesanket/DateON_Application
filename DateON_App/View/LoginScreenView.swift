//
//  LoginScreenView.swift
//  DateON_App
//
//  Created by Sanket Mule on 02/01/25.
//

import SwiftUI

struct LoginScreenView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoginSuccessful: Bool = false
    @State private var showErrorMessage: Bool = false
    
    var body: some View {
        ZStack {
            
            VStack(spacing: 20) {
                Text("DateON")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .underline(true, color: Color.pink)
                    .padding(.bottom, 10)
                
                Text("Login")
                    .font(.title)
                    .foregroundColor(.gray)
                
                VStack(spacing: 20) {
                    // Username TextField
                    VStack(alignment: .leading, spacing: 5) {
                        TextField("Enter your username", text: $username)
                            .padding(.bottom, 5)
                            .foregroundColor(.black)
                        
                        Divider()
                            .background(Color.pink)
                    }
                    
                    // Password SecureField
                    VStack(alignment: .leading, spacing: 5) {
                        SecureField("Enter your password", text: $password)
                            .padding(.bottom, 5)
                            .foregroundColor(.black)
                        
                        Divider()
                            .background(Color.pink)
                    }
                }
                .padding(.horizontal, 30)
                
                // Continue Button Gradient
                Button(action: handleLogin) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)
                
                if showErrorMessage {
                    Text("Invalid username or password")
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                // Social Media Section
                Text("or Connect With Social Media")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .padding(.vertical, 5)
                
                VStack(spacing: 15) {
                    SocialMediaButton(title: "Sign in With Twitter", color: .blue, icon: "bird.fill")
                    SocialMediaButton(title: "Sign in With Facebook", color: Color.blue.opacity(0.8), icon: "f.circle.fill")
                }
                .padding(.horizontal, 30)
                
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
                .padding(.bottom, 150)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(5)
            .padding(.horizontal, 10)
        }
    }
    
    private func handleLogin() {
        if username == "Admin" && password == "Admin" {
            isLoginSuccessful = true
            showErrorMessage = false
            print("Login successful")
        } else {
            isLoginSuccessful = false
            showErrorMessage = true
            print("Login failed")
        }
    }
}

struct SocialMediaButton: View {
    var title: String
    var color: Color
    var icon: String
    
    var body: some View {
        Button(action: {
            print("\(title) tapped")
        }) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.white)
                Text(title)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .cornerRadius(10)
        }
    }
}

struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
