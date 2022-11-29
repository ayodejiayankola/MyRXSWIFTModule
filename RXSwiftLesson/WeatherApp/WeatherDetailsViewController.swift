//
//  WeatherDetailsViewController.swift
//  RXSwiftLesson
//
//  Created by Ayodeji Ayankola on 17/11/2022.
//

import UIKit
import RxSwift
import RxCocoa

class WeatherDetailsViewController: UIViewController {

	@IBOutlet weak var cityNameTextField: UITextField?
	@IBOutlet weak var temperatureLabel: UILabel?
	@IBOutlet weak var humidityLabel: UILabel?
	
	let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
				
			self.cityNameTextField?.rx.controlEvent(.editingDidEndOnExit)
				.asObservable().map { self.cityNameTextField?.text }
				.subscribe(onNext: {city in
					if let city = city {
						if city.isEmpty {
							self.displayWeather(nil)
							
						} else {
							self.fetchWeather(by:city)
						}
					}
					
				}).disposed(by: disposeBag)

			
//			self.cityNameTextField?.rx.value
//				.subscribe(onNext: {city in
//					if let city = city {
//						if city.isEmpty {
//							self.displayWeather(nil)
//
//						} else {
//							self.fetchWeather(by:city)
//						}
//					}
//
//				}).disposed(by: disposeBag)
    }
	
	
	private func fetchWeather(by city: String) {
		
		guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
						let url = URL.urlForWeatherApi(city: cityEncoded) else { return }
		let resource = Resource<WeatherResult>(url: url)
		
//	let search = 	URLRequest.load(resource: resource)
//			.observe(on: MainScheduler.instance)
//			.catchAndReturn(WeatherResult.empty)
		
	/*	let search = 	URLRequest.load(resource: resource)
				.observe(on: MainScheduler.instance)
				.asDriver(onErrorJustReturn: WeatherResult.empty) */
		let search = URLRequest.load(resource: resource)
			.retry(3)
			.observe(on: MainScheduler.instance)
			.catch { errror in
				print(errror.localizedDescription)
				return Observable.just(WeatherResult.empty)
			}.asDriver(onErrorJustReturn: WeatherResult.empty)
		
//		search.map {  "\($0?.main.humidity)  Ḟ" }
//			.bind(to: (self.humidityLabel?.rx.text)!).disposed(by: disposeBag)
//
//		search.map {  "\($0?.main.temp) ⛈" }
//			.bind(to: (self.temperatureLabel?.rx.text)!).disposed(by: disposeBag)
	/*	search.map {  "\($0?.main.humidity ?? 0.0)  Ḟ" }
			.drive( (self.humidityLabel?.rx.text)!).disposed(by: disposeBag)

		search.map {  "\($0?.main.temp ?? 0.0) ⛈" }
			.drive( (self.temperatureLabel?.rx.text)!).disposed(by: disposeBag) */
		
		search.map {  "\($0.main.humidity ?? 0.0)  Ḟ" }
			.drive( (self.humidityLabel?.rx.text)!).disposed(by: disposeBag)

		search.map {  "\($0.main.temp ?? 0.0) ⛈" }
			.drive( (self.temperatureLabel?.rx.text)!).disposed(by: disposeBag)
		
//
//			.subscribe(onNext: { result in
//				let weather = result?.main
//				self.displayWeather(weather)
//
//			}).disposed(by: disposeBag)
		
	}
	
	private func displayWeather(_ weather: Weather?) {
		
		if let weather = weather {
			self.temperatureLabel?.text = "\(weather.temp) Ḟ"
			self.humidityLabel?.text = "\(weather.humidity) ⛈"
		} else {
			self.temperatureLabel?.text = "🙈"
			self.humidityLabel?.text = "🛑"
		}
	}
    
}
