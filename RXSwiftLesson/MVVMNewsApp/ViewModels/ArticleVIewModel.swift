//
//  ArticleVIewModel.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 02/12/2022.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
	let articlesVM: [ArticleViewModel]
}

extension ArticleListViewModel {
	init(_ articles: [ArticleRoot]) {
		self.articlesVM = articles.compactMap(ArticleViewModel.init)
	}
}

extension ArticleListViewModel {
	func articleAt(_ index: Int) -> ArticleViewModel {
		return self.articlesVM[index]
	}
}


struct ArticleViewModel {
	let article: ArticleRoot
	
	init(_ article: ArticleRoot) {
		self.article = article
	}
}

extension ArticleViewModel {
	var title: Observable<String> {
		return Observable<String>.just(article.title)
	}
	
	var description: Observable<String> {
		return Observable<String>.just(article.description ?? "")
	}
}
