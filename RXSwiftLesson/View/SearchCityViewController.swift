//
//  ViewController.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 02/09/2022.
//

import UIKit
import RxSwift
import RxDataSources

class SearchCityViewController: UIViewController {
	@IBOutlet weak var roundedView: UIView!
	@IBOutlet weak var searchTextField: UITextField!
	@IBOutlet weak var tableView: UITableView!
	
	private var viewModel: SearchCityViewPresentable!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}
}


