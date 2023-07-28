//
//  APIService.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import Foundation

private enum Constants {
    static let apiKey: String = "8643223550e74bf697382b1458fb72b5"
}

class APIService {
    private let baseURL = "https://newsapi.org/v2/everything"
    private let topHeadlineBaseURL = "https://newsapi.org/v2/top-headlines"
    
    private func performAPICall(with url: URL, completion: @escaping (ModelForNewsRemote?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, responce, error) in
            
            if let error = error {
                print("Error fetching data: \(String(describing: data)) ")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResult = try decoder.decode(ModelForNewsRemote.self, from: data)
                completion(apiResult)
                print("data: \(apiResult)")
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil)
            }
        }
            .resume()
    }
    
    // MARK: - A method to get all the news in the country
//    func fetchNewsInCountry(completion: @escaping(ModelForNewsRemote?) -> Void) {
//        let urlString = "\(topHeadlineBaseURL)?country=ua&apiKey=\(Constants.apiKey)"
//
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            completion(nil)
//            return
//        }
//
//        performAPICall(with: url, completion: completion)
//    }
    func fetchNewsInCountry(completion: @escaping (Result<ModelForNewsRemote?, Error>) -> Void) {
        let urlString = "\(topHeadlineBaseURL)?country=ua&apiKey=\(Constants.apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        performAPICall(with: url) { result in
            completion(.success(result))
        }
    }

    
    // MARK: - Method for getting news by keyword
    func searchNewsWithKeyword(withKeyword keyword: String, completion:@escaping (Result<ModelForNewsRemote?, Error>) -> Void) {
        let urlString = "\(baseURL)?apiKey=\(Constants.apiKey)&q=\(keyword)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(.failure(NSError(domain: "Invalid URL", code: -1, userInfo: nil)))
            return
        }
        
        performAPICall(with: url) { result in
            completion(.success(result))
        }
    }
}
