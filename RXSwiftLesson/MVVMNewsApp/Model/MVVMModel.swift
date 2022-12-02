//
//  MVVMModel.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 01/12/2022.
//

import Foundation

struct ArticlesResponse: Decodable {
		let articles: [ArticleRoot]
}

struct ArticleRoot: Decodable {
		let title: String
		let description: String?
}
