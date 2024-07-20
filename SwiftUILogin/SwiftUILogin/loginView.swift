//
//  ContentView.swift
//  SwiftUILogin
//
//  Created by Vijay Reddy on 12/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = LoginViewModel()
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            TextField("User Name", text: $viewModel.loginCredentials.userName)
                .padding()
                .border(Color.black)
            Text(viewModel.userNameMessage)
                .foregroundStyle(Color.red)
            
            SecureField("Password", text: $viewModel.loginCredentials.password)
                .padding()
                .border(Color.black)
            
            
            Text(viewModel.passwordMessage)
                .foregroundStyle(Color.red)
            Spacer()
            Button(action: {
                showAlert = true
            }, label: {
                Text("Login")
                
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    
                    .foregroundStyle(Color.white)
                    .background(Color.cyan)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
            }).disabled(!viewModel.isLoginEnable)
        }
        .padding()
        .alert( isPresented: $showAlert) {
            Alert(title: Text("Login success"), message: Text("User login success"))
        }
    }
}

#Preview {
    ContentView()
}
