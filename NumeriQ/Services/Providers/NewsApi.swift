//
//  NewsApi.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import Foundation
import Moya

/// Enum representing the different endpoints available for NewsApi
public enum NewsApi {
    case articles(query: String, fromDate: Date)
}

// MARK: - Provider support

extension NewsApi: TargetType {

    private var apiKey: String { "77c5b11904b44faf9f01abb20f0c6f03" }
    public var baseURL: URL { URL(string: "http://newsapi.org/v2")! }
    public var path: String {
        switch self {
        case .articles:
            return "/everything"
        }
    }
    public var method: Moya.Method {
        .get
    }
    public var task: Task {
        switch self {
        case let .articles(query, fromDate):
            return .requestParameters(parameters: ["q": query.urlEscaped,
                                                   "from": DateFormatter.urlFormatter.string(from: fromDate),
                                                   "apiKey": apiKey,
                                                   "sortBy": "publishedAt"],
                                      encoding: URLEncoding.default)
        }
    }
    public var validationType: ValidationType {
        .successCodes
    }
    public var sampleData: Data {
        switch self {
        case .articles:
            return """
                {
                  "status": "ok",
                  "totalResults": 5358,
                  "articles": [
                    {
                      "source": {
                        "id": null,
                        "name": "Slashdot.org"
                      },
                      "author": "BeauHD",
                      "title": "Microsoft Engineer Gets Nine Years For Stealing $10 Million From Microsoft",
                      "description": "A former Microsoft software engineer from Ukraine has been sentenced to nine years in prison for stealing more than $10 million in store credit from Microsoft's online store. Ars Technica reports: From 2016 to 2018, Volodymyr Kvashuk worked for Microsoft as a…",
                      "url": "https://yro.slashdot.org/story/20/11/10/2252248/microsoft-engineer-gets-nine-years-for-stealing-10-million-from-microsoft",
                      "urlToImage": "https://a.fsdn.com/sd/topics/crime_64.png",
                      "content": "From 2016 to 2018, Volodymyr Kvashuk worked for Microsoft as a tester, placing mock online orders to make sure everything was working smoothly. The software automatically prevented shipment of physic… [+1421 chars]"
                    }
                  ]
                }
                """.data(using: .utf8) ?? .init()
        }
    }
    public var headers: [String: String]? {
        return nil
    }

}
