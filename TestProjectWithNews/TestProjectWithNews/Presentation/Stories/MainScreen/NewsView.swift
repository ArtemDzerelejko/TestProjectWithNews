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
                    SearchNewsTextField(title: "Search News", text: $searchKeyword) {
                        viewModel.searchNewsWithKeyword(searchKeyword)
                    }
                    
                    HStack {
                        DatePicker("Select start date", selection: $startDate, displayedComponents: .date)
                            .datePickerStyle(.compact) // Задаємо стиль віджета
                                                .padding()
                                                .labelsHidden()
                        Spacer()
                        Text("-")
                        Spacer()
                        
                        DatePicker("Select Date", selection: $endDate, displayedComponents: .date)
                                           .datePickerStyle(.compact)
                                           .padding()
                                           .labelsHidden()
                    }
                    Button (action: {
                        print(startDate)
                    }, label: {
                        Text("Натисніть щоб застосувати фільтрація по даті")
                    })
                    
                   
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: searchKeyword) { newValue in
                        if newValue.isEmpty {
                            viewModel.getNewsInCountry() // Виклик методу для отримання новин усіх країн при порожньому полі вводу
                        }
                    }

                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        List(viewModel.searchResults.isEmpty ? viewModel.articles : viewModel.searchResults, id: \.description) { article in
                            NavigationLink(destination: DetailView(article: article)) {
                                VStack(alignment: .leading) {
                                    Text(article.title ?? "")
                                        .font(.headline)
                                    Text(article.description ?? "")
                                        .font(.subheadline)
                                    
                                    Text(article.publishedAt ?? "")
                                        .font(.body)
                                }
                                .padding()
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .navigationBarTitle("News")
                .onAppear {
                    viewModel.getNewsInCountry() // Виклик методу для отримання новин всіх країн при завантаженні вигляду
                }
            }
        }
}

struct NewsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
