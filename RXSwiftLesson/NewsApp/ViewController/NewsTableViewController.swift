//
//  NewsTableViewController.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 07/11/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class NewsTableViewController: UITableViewController {
	
	
	let disposeBag = DisposeBag()
	
	private var articles = [Article]()
	
	override func viewDidLoad() {
			super.viewDidLoad()
			self.navigationController?.navigationBar.prefersLargeTitles = true
			
			populateNews()
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
			return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			return self.articles.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			
			guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as? NewsTableViewCell else {
					fatalError("ArticleTableViewCell does not exist")
			}
			
		cell.newsTitle?.text = self.articles[indexPath.row].title
		cell.newsDescription?.text = self.articles[indexPath.row].description
			
			return cell
			
	}
	
	
	
	
	
	
	
	private func populateNews(){
		URLRequest.loadTwo(resource: ArticlesList.all)
			.subscribe(onNext: { [weak self] result in
				if let result = result {
					self?.articles = result.articles
					DispatchQueue.main.async {
						self?.tableView.reloadData()
					}
				}
			}).disposed(by: disposeBag)

		
//		let url = URL(string: "https://newsapi.org/v2/top-headlines?country=NG&apiKey=9c19b082e9e141ca844ac84e894118f2")
//		Observable.just(url)
//			.flatMap { url -> Observable<Data> in
//				let request = URLRequest(url: url!)
//				return URLSession.shared.rx.data(request: request)
//			}.map { data -> [Article]? in
//				print(data)
//				return try? JSONDecoder().decode(ArticlesList.self, from: data).articles
//			}.subscribe(onNext: { [weak self] articleCheck in
//				print(articleCheck)
//				if let articles = articleCheck {
//					self?.articles = articles
//					print(self?.articles)
//					DispatchQueue.main.async {
//						self?.tableView.reloadData()
//					}
//				}
//			}).disposed(by: disposeBag)
	}
	
}


