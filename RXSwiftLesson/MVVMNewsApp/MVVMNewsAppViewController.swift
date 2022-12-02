//
//  MVVMNewsAppViewController.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 01/12/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MVVMNewsAppViewController: UITableViewController {

	let disposeBag = DisposeBag()
	
	
	private var articleListVM: ArticleListViewModel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
			
			populateNews()
    }
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.articleListVM == nil ? 0 : self.articleListVM.articlesVM.count
	}
	
	private func populateNews(){
		let url = URL(string: "https://newsapi.org/v2/top-headlines?country=NG&apiKey=9c19b082e9e141ca844ac84e894118f2")!
		let resource = Resource<ArticlesResponse>(url: url)
		URLRequest.loadThree(resource: resource).subscribe(onNext: { articleResponse in
			let articles = articleResponse.articles
			self.articleListVM = ArticleListViewModel(articles)
			
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}).disposed(by: disposeBag)
		
		
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
			fatalError(" ArticleTableViewCell is not found")
		}
		
		let articleVM = self.articleListVM.articleAt(indexPath.row)
		
		articleVM.title.asDriver(onErrorJustReturn: "")
			.drive((cell.titleLabel?.rx.text)!)
			.disposed(by: disposeBag)
		
		articleVM.description.asDriver(onErrorJustReturn: "")
			.drive(cell.descriptionLabel!.rx.text)
			.disposed(by: disposeBag)
		
		return cell
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
