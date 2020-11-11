//
//  HomeViewModel.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol HomeViewModelType {

    /// Notifies when the data is being loaded.
    var isLoading: BehaviorRelay<Bool> { get }

    /// All available articles.
    var articles: BehaviorRelay<[Article]> { get }

    /// Performs an API request to fetch all article with a given query and date.
    func fetchArticles(query: String, from date: Date)

}

struct HomeViewModel: HomeViewModelType {

    // MARK: - Dependencies

    private let articlesService: ArticlesServiceType

    // MARK: - Variables

    var isLoading: BehaviorRelay<Bool> = .init(value: false)
    var articles: BehaviorRelay<[Article]> = .init(value: [])

    // MARK: - Private

    private let disposeBag = DisposeBag()

    // MARK: - Initializers

    init(articlesService: ArticlesServiceType) {
        self.articlesService = articlesService
    }

}

// MARK: - HomeViewModelType

extension HomeViewModel {

    func fetchArticles(query: String, from date: Date) {
        isLoading.accept(true)

        articlesService
            .fetchArticles(query: query, fromDate: date)
            .do(onSuccess: { classes in
                self.isLoading.accept(false)
            }, onError: { error in
                self.isLoading.accept(false)
            })
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { (classes) in
                self.classes.accept(classes)
                self.filteredClasses.accept(classes)
            })
            .disposed(by: disposeBag)
    }

}
