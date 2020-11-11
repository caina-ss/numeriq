//
//  ArticlesServiceTests.swift
//  NumeriQTests
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import XCTest
import Moya
import RxBlocking
@testable import NumeriQ

class ArticlesServiceTests: XCTestCase {

    /// Given an instance of `ArticlesService`
    /// When fetching all available articles for a given query and date
    /// Then it should return an array with 1 item
    /// And such item should have the same values as provided by the stub
    func testProvider_FetchArticles_Success() throws {
        let provider = MoyaProvider<NewsApi>(stubClosure: MoyaProvider.immediatelyStub)
        let dataSource = ArticlesService(provider: provider)
        let articles = try dataSource.fetchArticles(query: "bitcoin", fromDate: Date()).toBlocking().single()

        XCTAssertEqual(articles.count, 1)

        let article = articles.first

        XCTAssertNotNil(articles.first)
        XCTAssertEqual(article?.source.name, "Slashdot.org")
        XCTAssertEqual(article?.author, "BeauHD")
        XCTAssertEqual(article?.title, "Microsoft Engineer Gets Nine Years For Stealing $10 Million From Microsoft")
        XCTAssertEqual(article?.description, "A former Microsoft software engineer from Ukraine has been sentenced to nine years in prison for stealing more than $10 million in store credit from Microsoft's online store. Ars Technica reports: From 2016 to 2018, Volodymyr Kvashuk worked for Microsoft as a…")
        XCTAssertEqual(article?.url, "https://yro.slashdot.org/story/20/11/10/2252248/microsoft-engineer-gets-nine-years-for-stealing-10-million-from-microsoft")
        XCTAssertEqual(article?.urlToImage, "https://a.fsdn.com/sd/topics/crime_64.png")
        XCTAssertEqual(article?.content, "From 2016 to 2018, Volodymyr Kvashuk worked for Microsoft as a tester, placing mock online orders to make sure everything was working smoothly. The software automatically prevented shipment of physic… [+1421 chars]")
    }

    /// Given an instance of `ArticlesService` initialized with a failed sample response
    /// When fetching all available articles for a given query and date
    /// Then an error of type `MoyaError.underlying` should be thrown
    /// And it should contain another error of type `MoyaError.statusCode` with code 500 and empty data
    func testProvider_FetchArticles_Failure() throws {
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
        let dataSource = ArticlesService(provider: provider)

        XCTAssertThrowsError(try dataSource.fetchArticles(query: "bitcoin", fromDate: Date()).toBlocking().single()) { error in
            if case let .underlying(err, _) = error as? MoyaError,
               case let .statusCode(response) = err as? MoyaError {
                XCTAssertEqual(response.statusCode, 500)
                XCTAssertTrue(response.data.isEmpty)
            } else {
                XCTFail("Expected '.statusCode' but got \(error)")
            }
        }
    }

}
