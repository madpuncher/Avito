//
//  NetworkManager.swift
//  Avito
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 28.08.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    struct ConstantAPI {
        static let url = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    }
    
    func getData(completion: @escaping (Result<Company,Error>) -> Void) {
        guard let url = URL(string: ConstantAPI.url) else {
            completion(.failure(ErrorResponse.badURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                error == nil,
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completion(.failure(ErrorResponse.badServerResponse))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let response = try decoder.decode(EmployeeInfo.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response.company))
                }
            } catch let error {
                completion(.failure(ErrorResponse.cantGetData))
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
