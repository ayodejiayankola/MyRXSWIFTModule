//
//  Task.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 24/10/2022.
//

import Foundation

enum Priority: Int {
	case high
	case medium
	case low
}
struct Task {
	let title: String
	let priority: Priority
}
