//
//  NewsUseCase.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import Foundation

final class NewsUseCase {
    
    private let newsRepository: NewsRepositoryProtocol = NewsRepository()
    
    func creatingRequestToTheServerToGetNews(completion: @escaping (Result<ModelForNews, Error>) -> Void) {
        newsRepository.creatingRequestToTheServerToGetNews(completion: completion)
    }
    
    func searchNewsByKeyword(_ keyword: String, completion: @escaping (Result<ModelForNews, Error>) -> Void) {
        newsRepository.searchNewsByKeyword(keyword, completion: completion)
    }
    
    func searchNewsOverPeriodOfTime(startDate: Date, endDate: Date,
                                    completion: @escaping (Result<ModelForNews? , Error>) -> Void) {
        newsRepository.searchNewsOverPeriodOfTime(startDate: startDate, endDate: endDate, completion: completion)
    }
}
