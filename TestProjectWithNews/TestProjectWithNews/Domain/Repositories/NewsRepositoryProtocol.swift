//
//  NewsRepositoryProtocol.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import Foundation

protocol NewsRepositoryProtocol {
    func creatingRequestToTheServerToGetNews(completion: @escaping (Result<ModelForNews, Error>) -> Void)
    
    func searchNewsByKeyword(_ keyword: String, completion: @escaping (Result<ModelForNews, Error>) -> Void)
    
    func searchNewsOverPeriodOfTime(startData: Date, endData: Date, completion: @escaping (Result<ModelForNews? , Error>) -> Void)
}
