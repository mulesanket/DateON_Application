//
//  LoginScreenView.swift
//  DateON_App
//
//  Created by Sanket Mule on 08/01/25.
//

import SwiftUI

struct LoginScreenView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var isRegisterUserSheetPresented = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(Title.DateON.rawValue)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .underline(true, color: Color.pink)
                
                Text(Title.Login.rawValue)
                    .font(.title2)
                    .foregroundColor(.gray)
                
                VStack(spacing: 20) {
                    CustomTextField(placeholder: LoginScreenMessage.EnterUserName.rawValue, text: $viewModel.enteredUsername)
                    CustomSecureField(placeholder: LoginScreenMessage.EnterPassword.rawValue, text: $viewModel.enteredPassword)
                }
                .padding(.horizontal, 30)
                
                Button(action: viewModel.validateLogin) {
                    Text(ButtonTitle.Continue.rawValue)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .leading, endPoint: .trailing))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)
                
                if viewModel.shouldShowErrorMessage {
                    Text(LoginScreenMessage.InvalidCredentials.rawValue)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                
                Spacer()
                
                VStack(spacing: 5) {
                    Text(LoginScreenMessage.NOaccount.rawValue)
                        .foregroundColor(.gray)
                    Button(action: {
                        isRegisterUserSheetPresented = true
                    }) {
                        Text(LoginScreenMessage.RegisterHere.rawValue)
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
        .sheet(isPresented: $isRegisterUserSheetPresented) {
            RegisterNewUserView()
        }
    }
    
    // MARK: - Custom TextField and SecureField
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
        
        @State private var isPasswordVisible: Bool = false
        
        var body: some View {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    if isPasswordVisible {
                        TextField(placeholder, text: $text)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .foregroundColor(.black)
                    } else {
                        SecureField(placeholder, text: $text)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                        
                            .foregroundColor(.gray)
                    }
                }
                
                Divider()
                    .background(Color.pink)
            }
        }
    }
}

// MARK: - Preview
struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
    }
}
