//
//  AddTaskViewController.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 24/10/2022.
//

import Foundation
import UIKit
import RxSwift

class AddTaskViewController: UIViewController {
	
	private let taskSubject = PublishSubject<Task>()
	
	var taskSubjectObservable: Observable<Task> {
		return taskSubject.asObservable()
	}
	
	
	@IBOutlet weak var prioritySegementedControl: UISegmentedControl?
	@IBOutlet weak var taskTitleTextField: UITextField?
	
	@IBAction func save() {
		guard let  priority = Priority(rawValue: self.prioritySegementedControl!.selectedSegmentIndex), let title = self.taskTitleTextField?.text
 else {
			return
		}
		let task = Task(title: title, priority: priority)
		self.taskSubject.onNext(task)
		self.dismiss(animated: true, completion: nil)
	}
}
