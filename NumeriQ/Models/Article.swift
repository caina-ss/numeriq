//
//  Article.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import Foundation

/// Model representing an article
struct Article: Decodable, Equatable {
    let source: Source
    let author: String
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let publishedAt: Date
    let content: String
}

#if DEBUG
extension Article {

    static var mock: Article {
        Article(source: .init(id: nil, name: "Slashdot.org"),
                author: "BeauHD",
                title: "Microsoft Engineer Gets Nine Years For Stealing $10 Million From Microsoft",
                description: "A former Microsoft software engineer from Ukraine has been sentenced to nine years in prison for stealing more than $10 million in store credit from Microsoft's online store. Ars Technica reports: From 2016 to 2018, Volodymyr Kvashuk worked for Microsoft as a…",
                url: "https://yro.slashdot.org/story/20/11/10/2252248/microsoft-engineer-gets-nine-years-for-stealing-10-million-from-microsoft",
                urlToImage: "https://a.fsdn.com/sd/topics/crime_64.png",
                publishedAt: Date(),
                content: "From 2016 to 2018, Volodymyr Kvashuk worked for Microsoft as a tester, placing mock online orders to make sure everything was working smoothly. The software automatically prevented shipment of physic… [+1421 chars]")
    }

}
#endif
