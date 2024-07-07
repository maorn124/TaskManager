//
//  SignInView.swift
//  TaskManager
//
//  Created by Maor Niv on 7/6/24.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    @EnvironmentObject var authManager: FirebaseAuthManager
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
            
            Button(action: {
                isSignUp ? signUp() : signIn()
            }) {
                Text(isSignUp ? "Sign Up" : "Sign In")
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
            Button(action: {
                isSignUp.toggle()
            }) {
                Text(isSignUp ? "Have an account? Sign In" : "Don't have an account? Sign Up")
            }
        }
        .padding()
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    private func signIn() {
        authManager.signIn(email: email, password: password) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                errorMessage = error.localizedDescription
                showErrorAlert = true
            }
        }
    }
    
    private func signUp() {
        authManager.signUp(email: email, password: password) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                errorMessage = error.localizedDescription
                showErrorAlert = true
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().environmentObject(FirebaseAuthManager())
    }
}
