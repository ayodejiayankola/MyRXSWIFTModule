//
//  TaskListViewController.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 24/10/2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
	
	
	@IBOutlet weak var prioritySegementedControl: UISegmentedControl!
	@IBOutlet weak var tableView: UITableView?
	
	let disposeBag = DisposeBag()
//	let taskModel = Task()
	private var tasks = BehaviorRelay<[Task]>(value: [])
	private var filteredTask = [Task]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.navigationController?.navigationBar.prefersLargeTitles = true
	}
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.filteredTask.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell =  tableView.dequeueReusableCell(withIdentifier: "TaskListCell", for: indexPath)
		
		cell.textLabel?.text = self.filteredTask[indexPath.row].title
		return cell
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		guard let navVC = segue.destination as? UINavigationController,
		let taskVC = navVC.viewControllers.first as? AddTaskViewController
		else { fatalError("controller is not found") }
		taskVC.taskSubjectObservable.subscribe(onNext: { [unowned self] task in
			print(task)
			
			let priority = Priority(rawValue: self.prioritySegementedControl.selectedSegmentIndex - 1)
			
			
			
			var existingTasks = self.tasks.value
			existingTasks.append(task)
			self.tasks.accept(existingTasks)
			self.filterTask(by: priority)
		}).disposed(by: disposeBag)
		
		
	}
	
	private func updateTableView(){
		DispatchQueue.main.async {
			self.tableView?.reloadData()
		}
	}
	
	@IBAction func selectedPriorityControl(segementedControl: UISegmentedControl) {
		let priority = Priority(rawValue: self.prioritySegementedControl.selectedSegmentIndex - 1)
		self.filterTask(by: priority)
	}
	private func filterTask(by priority: Priority?) {
		if priority == nil {
			self.filteredTask = self.tasks.value
			self.updateTableView()
		} else {
			self.tasks.map { tasks in
				// Mapped the numbers to the enum
				return tasks.filter {$0.priority == priority!}
			}.subscribe(onNext: { [weak self] tasks in
				// Return filtered array
				self?.filteredTask = tasks
//				print(self.filteredTask)
				self?.updateTableView()
			}).disposed(by: disposeBag)
		}
		
	}

}
