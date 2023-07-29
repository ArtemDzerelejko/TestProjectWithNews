//
//  APIService.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import Foundation

private enum Constants {
    static let baseURL: String = "https://newsapi.org/v2/everything"
    static let topHeadlineBaseURL: String = "https://newsapi.org/v2/top-headlines"
    //    static let apiKey: String = "8643223550e74bf697382b1458fb72b5"
    static let apiKey: String = "b29c39ecce764b31a4bbd88b2d8acaaf"
    static let dateFormat: String = "yyyy-MM-dd"
}

private enum NewsError: Error {
    case invalidURL
    case noDataReceived
}

class APIService {
    
    private static func makeURL(withBaseURL baseURL: String, parameters: [String: String]) -> URL? {
        var components = URLComponents(string: baseURL)
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
    
    private func performAPICall(with url: URL, completion: @escaping (ModelForNewsRemote?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, responce, error) in
            
            if let error = error {
                print(Strings.errorFetchingData + "\(String(describing: data)) ")
                print(error)
                completion(nil)
                return
            }
            
            guard let data = data else {
                print(Strings.noDataReceived)
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let apiResult = try decoder.decode(ModelForNewsRemote.self, from: data)
                completion(apiResult)
                print("data: \(apiResult)")
            } catch {
                print(Strings.errorParsingJSON + "\(error)")
                completion(nil)
            }
        }
            .resume()
    }
    
    // MARK: - A method to get all the news in the country
    func fetchNewsInCountry(completion: @escaping (Result<ModelForNewsRemote?, Error>) -> Void) {
        guard let url = APIService.makeURL(withBaseURL: Constants.topHeadlineBaseURL, parameters: ["country": "ua", "apiKey": Constants.apiKey]) else {
            completion(.failure(NewsError.invalidURL))
            return
        }
        
        performAPICall(with: url) { result in
            completion(.success(result))
        }
    }
    
    
    // MARK: - Method for getting news by keyword
    func searchNews(withKeyword keyword: String, completion:@escaping (Result<ModelForNewsRemote?, Error>) -> Void) {
        guard let url = APIService.makeURL(withBaseURL: Constants.baseURL, parameters: ["q": keyword, "apiKey": Constants.apiKey]) else {
            completion(.failure(NewsError.invalidURL))
            return
        }
        
        performAPICall(with: url) { result in
            completion(.success(result))
        }
    }
    
    //MARK: - A method that searches for news for a certain period of time
    func searchNewsOverPeriodOfTime(startDate: Date, endDate: Date, completion: @escaping (Result<ModelForNewsRemote? , Error>) -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        guard let url = APIService.makeURL(withBaseURL: Constants.baseURL, parameters: ["q": "Ukraine", "from": startDateString, "to": endDateString, "sortBy": "popularity", "apiKey": Constants.apiKey]) else {
            completion(.failure(NewsError.invalidURL))
            return
        }
        
        performAPICall(with: url) { result in
            completion(.success(result))
        }
    }
}
