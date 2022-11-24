//
//  Article.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 09/11/2022.
//

import Foundation

struct ArticlesList: Decodable {
		let articles: [Article]
}

struct Article: Decodable {
		let title: String
		let description: String?
}


extension ArticlesList {
	static var all: Resource<ArticlesList> = {
		let url = URL(string:  "https://newsapi.org/v2/top-headlines?country=NG&apiKey=9c19b082e9e141ca844ac84e894118f2")!
		return Resource(url: url)
	}()
}
