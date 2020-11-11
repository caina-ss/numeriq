//
//  HomeViewModelTests.swift
//  NumeriQTests
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import Moya
import Swinject
import SwinjectStoryboard
@testable import NumeriQ

class HomeViewModelTests: XCTestCase {

    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    override func setUpWithError() throws {
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
    }

    /// Given an instance of `HomeViewModel`
    /// When fetching articles with a successful response (containing 1 item)
    /// Then the observer should receive one initial event containing an empty array
    /// And the observer should receive one extra event containing an array with the item
    func testFetchArticles_SuccessfulResponse() {
        let articles = scheduler.createObserver([Article].self)
        let provider = MoyaProvider<NewsApi>(stubClosure: MoyaProvider.immediatelyStub)
        let articlesService = ArticlesService(provider: provider)
        let viewModel = HomeViewModel(articlesService: articlesService)
        viewModel
            .articles
            .asDriver(onErrorJustReturn: [])
            .drive(articles)
            .disposed(by: disposeBag)

        viewModel.fetchArticles(query: "bitcoin", from: Date())

        scheduler.start()

        XCTAssertEqual(articles.events, [
            .next(0, []),
            .next(0, [Article.mock])
        ])
    }

    /// Given an instance of `HomeViewModel`
    /// When fetching classes with a failed response (status code 500)
    /// Then the observer should receive one initial event containing an empty array
    /// And the observer should receive another event containing an empty array
    func testFetchArticles_FailedResponse() {
        let articles = scheduler.createObserver([Article].self)
        let provider = MoyaProvider<NewsApi>(endpointClosure: { target -> Endpoint in
            let sampleResponseClosure = { () -> EndpointSampleResponse in
                return .networkResponse(500, .init())
            }

            // all the request properties should be the same as your default provider
            let method = target.method
            let endpoint = Endpoint(url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                                    sampleResponseClosure: sampleResponseClosure,
                                    method: method,
                                    task: target.task,
                                    httpHeaderFields: [:])
            return endpoint.adding(newHTTPHeaderFields: target.headers ?? [:])
        }, stubClosure: MoyaProvider.immediatelyStub)
        let articlesService = ArticlesService(provider: provider)
        let viewModel = HomeViewModel(articlesService: articlesService)
        viewModel
            .articles
            .asDriver(onErrorJustReturn: [])
            .drive(articles)
            .disposed(by: disposeBag)

        viewModel.fetchArticles(query: "bitcoin", from: Date())

        scheduler.start()

        XCTAssertEqual(articles.events, [
            .next(0, []),
            .next(0, [])
        ])
    }

}
