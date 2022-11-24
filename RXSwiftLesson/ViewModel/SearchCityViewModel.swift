//
//  SearchCityViewModel.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 06/09/2022.
//

import RxCocoa

//import Foundation

protocol SearchCityViewPresentable {
	
	typealias Input = (
		searchText: Driver<String>, ()
	)
	typealias Output = ()
	typealias viewModelBuilder = (Input)
	var input: SearchCityViewPresentable.Input { get }
	var output: SearchCityViewPresentable.Output { get }
}
class SearchCityViewModel: SearchCityViewPresentable {
	
	var input: SearchCityViewPresentable.Input
	
	var output: SearchCityViewPresentable.Output
	
	init (input: SearchCityViewPresentable.Input) {
		self.input = input
		self.output = SearchCityViewModel.output(input: self.input)
	}
}

private extension SearchCityViewModel {
	static func output(input: SearchCityViewPresentable.Input) -> SearchCityViewPresentable.Output {
		return ()
	}
}
