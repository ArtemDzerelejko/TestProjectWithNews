//
//  NewsRepository.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import Foundation

final class NewsRepository: NewsRepositoryProtocol {
    
    private let apiService = APIService()
    
    // MARK: - Creating request to the server to get news
    func creatingRequestToTheServerToGetNews(completion: @escaping (Result<ModelForNews, Error>) -> Void) {
        apiService.fetchNewsInCountry { result in
            switch result {
            case .success(let modelForNewsRemote):
                if let remoteData = modelForNewsRemote {
                    let modelForNews = ModelForNews(remote: remoteData)
                    completion(.success(modelForNews))
                } else {
                    let error = NSError(domain: Strings.errorFetchingNewsInCountry, code: 0, userInfo: nil)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Search news by keyword
    func searchNewsByKeyword(_ keyword: String,
                             completion: @escaping (Result<ModelForNews, Error>) -> Void) {
        apiService.searchNews(withKeyword: keyword) { result in
            switch result {
            case .success(let modelForNewsRemote):
                if let remoteData = modelForNewsRemote {
                    let modelForNews = ModelForNews(remote: remoteData)
                    completion(.success(modelForNews))
                } else {
                    let error = NSError(domain: Strings.errorFetchingNewsWithKeyword, code: 0, userInfo: nil)
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Search news over period of time
    func searchNewsOverPeriodOfTime(startDate: Date,
                                    endDate: Date,
                                    completion: @escaping (Result<ModelForNews?, Error>) -> Void) {
        apiService.searchNewsOverPeriodOfTime(startDate: startDate, endDate: endDate) { result in
            switch result {
            case .success(let modelForNewsRemote):
                if let remoteData = modelForNewsRemote {
                    let modelForNews = ModelForNews(remote: remoteData)
                    completion(.success(modelForNews))
                } else {
                    let errror = NSError(domain: Strings.errorFetchingNewsInTheseDates, code: -1, userInfo: nil)
                    completion(.failure(errror))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
