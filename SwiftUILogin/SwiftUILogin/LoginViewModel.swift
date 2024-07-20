//
//  LoginViewModel.swift
//  SwiftUILogin
//
//  Created by Vijay Reddy on 12/07/24.
//

import Combine

struct LoginCredentials {
    var userName: String = ""
    var password: String = ""
}

class LoginViewModel : ObservableObject {
    
    let networkManager: ServiceProtocol
    
    // User validation
    @Published var userNameMessage = ""
    @Published var passwordMessage = ""
    @Published var isLoginEnable = false
    @Published var loginCredentials = LoginCredentials()
    
    //Server response
    @Published var loginResponse: User?
    @Published var loginError: Error?
    
    var cancelable = Set<AnyCancellable>()
    
    init(networkManager: ServiceProtocol = NetworkManager()) {
        self.networkManager = networkManager
        
        userInputHandling()
    }
    
    func userInputHandling() {
        
        $loginCredentials.map{ [weak self] credentials in
            return (self?.userNameValidations(username: credentials.userName), self?.passwordValidation(password: credentials.password))
        }.sink {[weak self] userMsg, pswMsg in
            self?.userNameMessage = userMsg ?? ""
            self?.passwordMessage = pswMsg ?? ""
            self?.isLoginEnable = ((self?.enableLoginCredentials()) != nil)
        }.store(in: &cancelable)
        
    }
    
    
    func loginServiceCall() {
        let inputRequest = ["UserName": "", "Password": ""]
        networkManager.loginServiceCall(inputResuest: inputRequest) { [weak self] response in
            
            switch response {
            case .success(let userResponse):
                self?.loginResponse = userResponse
                
            case .failure(let failure):
                self?.loginError = failure
                
            }
        }
    }
    
    func userNameValidations(username: String) -> String {
        
        if username == "" {
            return "Please enter UserName"
        } else if username.count < 6 {
           return "User name Should be more than 6 charecters"
        }
        return ""
    }
    
    func passwordValidation(password: String) -> String {
        if password == "" {
            return "Please enter password"
        } else if password.count < 6 {
            return "Password should be more than 6 charecters"
        }
        return ""
    }
    
    func enableLoginCredentials() -> Bool {
        return userNameMessage.isEmpty && passwordMessage.isEmpty
    }
 }
