//
//  ApiService.swift
//  Assesment
//
//  Created by Fawad Akhtar on 05/22/2024.
//

import Foundation


enum apiEndPoints: String {
    case dessertList = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    case dessertDetail = "https://themealdb.com/api/json/v1/1/lookup.php?i="
}

class APIService {
    static let shared = APIService()
    private init() {}
    
    func fetchData<T: Codable>(urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch let decodingError {
                completion(.failure(decodingError))
            }
        }.resume()
    }
}
