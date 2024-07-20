//
//  NetworkLayer.swift
//  SwiftUILogin
//
//  Created by Vijay Reddy on 12/07/24.
//

import Foundation



protocol ServiceProtocol {
    
    func loginServiceCall(inputResuest: [String: Any], completion: @escaping (Result<User, Error>) -> Void )
}

class NetworkManager: ServiceProtocol {
    
    func loginServiceCall(inputResuest: [String : Any], completion: @escaping (Result<User, Error>) -> Void) {
        
        guard let url = URL(string: "") else {
            return
        }
        
         URLSession.shared.dataTask(with: url) { data,  urlresponse, error  in

            guard let data = data, let urlresponse = urlresponse as? HTTPURLResponse, urlresponse.statusCode == 200 else { return}
            
            do {
                let userData = try JSONDecoder().decode(User.self , from: data)
                completion(.success(userData))
            }
            catch let error {
                completion(.failure(error))
            }
        }.resume()
        
    }
}

struct User: Codable {
    let name: String
    let mobileNumber: String
    let email: String
}
