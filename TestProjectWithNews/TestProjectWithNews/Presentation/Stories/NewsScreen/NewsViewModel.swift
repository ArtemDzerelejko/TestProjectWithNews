//
//  MainScreenViewModel.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import Foundation

private enum Constants {
    static let dateFormat: String = "yyyy-MM-dd HH:mm:ss Z"
}

final class NewsViewModel: ObservableObject {
    
    @Published var articles: [Article] = []
    @Published var searchResults: [Article] = []
    @Published var isLoading: Bool = false
    @Published var filteredArticles: [Article] = []
    private let newsUseCase = NewsUseCase()
    
    // MARK: - Get news in country
    func getNewsInCountry() {
        
        isLoading = true
        
        newsUseCase.creatingRequestToTheServerToGetNews { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let modelForNews):
                    if let articles = modelForNews.articles {
                        self.articles = articles
                    } else {
                        self.articles = []
                    }
                case .failure(let error):
                    print(Strings.errorSearchingNews + "\(error)")
                }
            }
        }
    }
    
    // MARK: - Search nesw with keyword
    func searchNewsWithKeyword(_ keyword: String) {
        
        isLoading = true
        
        newsUseCase.searchNewsByKeyword(keyword) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let modelForNews):
                    if let articles = modelForNews.articles {
                        self.searchResults = articles
                    } else {
                        self.searchResults = []
                    }
                case .failure(let error):
                    print(Strings.errorSearchingNews + "\(error)")
                }
            }
        }
    }
    
    // MARK: - Search news over period of time
    func searchNewsOverPeriodOfTime(startDate: Date, endDate: Date) {
        
        isLoading = true
        
        newsUseCase.searchNewsOverPeriodOfTime(startDate: startDate, endDate: endDate) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false
                
                switch result {
                case .success(let modelForNews):
                    if let articles = modelForNews?.articles {
                        self.searchResults = articles
                        self.filterArticles(startDate: startDate, endDate: endDate)
                    } else {
                        self.searchResults = []
                    }
                case .failure(let error):
                    print(Strings.errorSearchingNews + "\(error)")
                }
            }
        }
    }
    
    // MARK: - Filter articles
    func filterArticles(startDate: Date, endDate: Date) {
        filteredArticles = articles.filter { article in
            if let dateString = article.publishedAt {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = Constants.dateFormat
                if let date = dateFormatter.date(from: dateString) {
                    return date >= startDate && date <= endDate
                }
            }
            return false
        }
    }
}
