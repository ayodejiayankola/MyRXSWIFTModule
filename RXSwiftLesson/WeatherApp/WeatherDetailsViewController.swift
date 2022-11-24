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
				
			self.cityNameTextField?.rx.value
				.subscribe(onNext: {city in
					if let city = city {
						if city.isEmpty {
							self.displayWeather(nil)
							
						} else {
							self.fetchWeather(by:city)
						}
					}
					
				}).disposed(by: disposeBag)
    }
	
	
	private func fetchWeather(by city: String) {
		
		guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
						let url = URL.urlForWeatherApi(city: cityEncoded) else { return }
		let resource = Resource<WeatherResult>(url: url)
		
		URLRequest.load(resource: resource)
			.observe(on: MainScheduler.instance)
			.catchAndReturn(WeatherResult.empty)
			.subscribe(onNext: { result in
				let weather = result?.main
				self.displayWeather(weather)
				
			}).disposed(by: disposeBag)
		
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
