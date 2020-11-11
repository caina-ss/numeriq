//
//  ArticlesService.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import Foundation
import Moya
import RxSwift

protocol ArticlesServiceType {

    /// Fetches all available articles for a given query and date.
    /// - Returns: A Single containing an array of `Article`s.
    func fetchArticles(query: String, fromDate: Date) -> Single<[Article]>

}

class ArticlesService {

    private let provider: MoyaProvider<NewsApi>

    init(provider: MoyaProvider<NewsApi>) {
        self.provider = provider
    }

}

extension ArticlesService: ArticlesServiceType {

    func fetchArticles(query: String, fromDate: Date) -> Single<[Article]> {
        provider.rx
            .request(.articles(query: query, fromDate: fromDate))
            .map([Article].self, atKeyPath: "articles")
    }

}
