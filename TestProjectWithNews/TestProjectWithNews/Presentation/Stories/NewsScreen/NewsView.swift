//
//  NewsView.swift
//  TestProjectWithNews
//
//  Created by artem on 28.07.2023.
//

import SwiftUI

struct NewsView: View {
    
    @StateObject private var viewModel = NewsViewModel()
    @State private var searchKeyword = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: - SearchNewsTextField
                SearchNewsTextField(title: Strings.search, text: $searchKeyword) {
                    viewModel.searchNewsWithKeyword(searchKeyword)
                }
                
                // MARK: - For searching by date
                HStack {
                    Image(systemName: Strings.calendar)
                        .font(.system(size: 25))
                        .padding()
                    DatePickerView(dateInDatePicker: $startDate)
                    Text("-")
                    DatePickerView(dateInDatePicker: $endDate)
                }
                
                Button(action: {
                    viewModel.searchNewsOverPeriodOfTime(startDate: startDate, endDate: endDate)
                    print(startDate)
                }, label: {
                    Text(Strings.searchByRelevantDates)
                        .foregroundColor(.white)
                })
                .padding(.all, 10)
                .background(Color.blue)
                .cornerRadius(10)
                Divider()
                
                // MARK: - View state Switch
                switch true {
                case viewModel.isLoading:
                    ProgressView()
                case !viewModel.filteredArticles.isEmpty:
                    ListView(article: viewModel.filteredArticles)
                case !viewModel.searchResults.isEmpty:
                    ListView(article: viewModel.searchResults)
                case !viewModel.articles.isEmpty:
                    ListView(article: viewModel.articles)
                default :
                    Text(Strings.noArticlesAvailable)
                }
            }
            .navigationBarTitle(Strings.news)
            .navigationBarTitleDisplayMode(.inline)
            
            .onAppear {
                viewModel.getNewsInCountry()
            }
        }
    }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
