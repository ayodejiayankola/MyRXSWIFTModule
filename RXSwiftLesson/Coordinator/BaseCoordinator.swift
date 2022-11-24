//
//  BaseCoordinator.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 16/09/2022.
//

import Foundation

class BaseCoordinator: Coordinator {
	var childCoordinator: [Coordinator] = []
	
	func start() {
		fatalError("Children should implement 'start' .")
	}
	
	
	
}
