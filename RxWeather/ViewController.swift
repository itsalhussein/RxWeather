//
//  ViewController.swift
//  RxWeather
//
//  Created by Hussein Anwar on 11/01/2023.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var humadityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var countryNameTF: UITextField!
    
    
    //MARK: - Propeties
    let disposeBag = DisposeBag()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.countryNameTF.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.countryNameTF.text }
            .subscribe(onNext: { city in 
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }

    private func displayWeather(_ weather : Weather?){
        if let weather = weather {
            
            DispatchQueue.main.async {
                self.tempLabel.text = "\(weather.current?.temperature) ℉"
                self.humadityLabel.text = "\(weather.current?.humidity) 💦"
            }
            
        } else {
            
            DispatchQueue.main.async {
                self.tempLabel.text = "🙈"
                self.humadityLabel.text = "∅"
            }
        }
    }
    
    private func fetchWeather(by city: String){
        
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        
        let resource = Resource<Weather>(url: url)
        
        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .catch { error in
                print(error.localizedDescription)
                return Observable.just(Weather.empty)
            }.asObservable()
        
        search.map { "\($0.current?.temperature ?? 0) ℉" }
            .bind(to: self.tempLabel.rx.text)
            .disposed(by: disposeBag)
            
        
        search.map { "\($0.current?.humidity ?? 0) 💦" }
            .bind(to: self.humadityLabel.rx.text)
            .disposed(by: disposeBag)
        
    }
    
    

}

