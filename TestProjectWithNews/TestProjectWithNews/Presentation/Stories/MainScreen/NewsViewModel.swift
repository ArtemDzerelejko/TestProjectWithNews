//
//  MainScreenViewModel.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//
import Foundation

class NewsViewModel: ObservableObject {
    @Published var articles: [Article] = []
    @Published var searchResults: [Article] = []
    @Published var isLoading: Bool = false

    private let newsUseCase = NewsUseCase()

    func getNewsInCountry() {
        isLoading = true

        newsUseCase.creatingRequestToTheServerToGetNews { result in
            DispatchQueue.main.async {
                self.isLoading = false

                switch result {
                case .success(let modelForNews):
                    if let articles = modelForNews.articles {
                        self.articles = articles
                    } else {
                        self.articles = []
                    }
                case .failure(let error):
                    print("Error searching news: \(error)")
                }
            }
        }
    }

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
                    print("Error searching news: \(error)")
                }
            }
        }
    }

    func searchNewsOverPeriodOfTime(startDate: Date, endDate: Date) {
        isLoading = true
        newsUseCase.searchNewsOverPeriodOfTime(startData: startDate, endData: endDate) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.isLoading = false

                switch result {
                case .success(let modelForNews):
                    if let articles = modelForNews?.articles {
                        self.searchResults = articles
                    } else {
                        self.searchResults = []
                    }
                case .failure(let error):
                    print("Error searching news: \(error)")
                }
            }
        }
    }
}
