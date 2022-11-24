//
//  URL+Extensions.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 24/11/2022.
//

import Foundation

extension URL {
	static func urlForWeatherApi(city: String) -> URL? {
		return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=67f0248f949a41e10828c7293393ad04")
	}
}
