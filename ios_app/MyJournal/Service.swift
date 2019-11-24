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
                print("Failed to fetch posts", error)
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
}
