//
//  ViewController.swift
//  GoodWeatherRx
//
//  Created by Maxim Bekmetov on 27.10.2022.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!

    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cityNameTextField.rx.value.subscribe(onNext: { city in
            if let city = city {
                if city.isEmpty {
                    self.displayWeather(nil)
                } else {
                    self.fetchWeather(by: city)
                }
            }

        }).disposed(by: disposeBag)

    }

    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }

        let resource = Resource<WeatherResult>(url: url)
        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catchAndReturn(WeatherResult.empty)
//            .subscribe(onNext: { result in
//
//            let weather = result.main
//            self.displayWeather(weather)
//        }).disposed(by: disposeBag)

        search.map { "\($0.main.temp) ℃" }.bind(to: self.temperatureLabel.rx.text).disposed(by: disposeBag)
        search.map { "\($0.main.humidity) 💦" }.bind(to: self.humidityLabel.rx.text).disposed(by: disposeBag)
    }

    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp) ℃"
            self.humidityLabel.text = "\(weather.humidity) 💦"
        } else {
            self.temperatureLabel.text = "🙈"
            self.humidityLabel.text = "🪹"
        }
    }
}
