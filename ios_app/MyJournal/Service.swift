//
//  Service.swift
//  MyJournal
//
//  Created by Cesare de Cal on 11/23/19.
//  Copyright © 2019 Cesare de Cal. All rights reserved.
//

import Foundation

class Service: NSObject {
    static let shared = Service()
    
    func fetchPosts(completion: @escaping (Result<[Post], Error>) -> ()) {
        guard let url = URL(string: "http://localhost:1337/posts") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }

            guard let data = data else { return }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                completion(.success(posts))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
    func createPost(title: String, body: String, completion: @escaping (Error?) -> ()) {
        guard let url = URL(string: "http://localhost:1337/post") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let params = ["title": title, "body": body]
        
        do {
            let data = try JSONSerialization.data(withJSONObject: params, options: .init())
            urlRequest.httpBody = data
            urlRequest.setValue("application/json", forHTTPHeaderField: "content-type")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                completion(nil)
            }.resume()
        } catch {
            completion(error)
        }
    }
    
    func deletePost(id: Int, completion: @escaping (Error?) -> ()) {
        guard let url = URL(string: "http://localhost:1337/post/\(id)") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(error)
                    return
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    let errorString = String(data: data ?? Data(), encoding: .utf8) ?? ""
                    completion(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorString]))
                    return
                }
                
                completion(nil)
            }
        }.resume()
    }
}
