//
//  NewsRepository.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import Foundation

final class NewsRepository: NewsRepositoryProtocol {
    
    private let apiService = APIService()
    
    func creatingRequestToTheServerToGetNews(completion: @escaping (Result<ModelForNews, Error>) -> Void) {
           apiService.fetchNewsInCountry { result in
               switch result {
               case .success(let modelForNewsRemote):
                   if let remoteData = modelForNewsRemote {
                       let modelForNews = ModelForNews(remote: remoteData)
                       completion(.success(modelForNews))
                   } else {
                       let error = NSError(domain: "Error fetching news in country", code: 0, userInfo: nil)
                       completion(.failure(error))
                   }
               case .failure(let error):
                   completion(.failure(error))
               }
           }
       }
    
    func searchNewsByKeyword(_ keyword: String, completion: @escaping (Result<ModelForNews, Error>) -> Void) {
            apiService.searchNewsWithKeyword(withKeyword: keyword) { result in
                switch result {
                case .success(let modelForNewsRemote):
                    if let remoteData = modelForNewsRemote {
                        let modelForNews = ModelForNews(remote: remoteData)
                        completion(.success(modelForNews))
                    } else {
                        let error = NSError(domain: "Error fetching news with keyword", code: 0, userInfo: nil)
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    
    private func performReguest(for url: URL, completion: @escaping (Result<ModelForNews, Error>) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                let error = NSError(domain: "Invalid Response Data", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                let error = NSError(domain: "Invalid Response Status Code", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "No Data Received", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResponse = try decoder.decode(ModelForNewsRemote.self, from: data)
                let modelForNews = ModelForNews(remote: apiResponse)
                completion(.success(modelForNews))
            } catch {
                completion(.failure(error))
            }
            
        }
            .resume()
    }
}
