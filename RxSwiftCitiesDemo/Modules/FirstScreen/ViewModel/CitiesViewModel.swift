//
//  FirstScreenViewModel.swift
//  RxSwiftCitiesDemo
//
//  Created by Haidy Saeed on 15/01/2025.
//

import RxSwift
import RxCocoa

class CitiesViewModel {
    private let cityService = City.shared.getCities()
    private let disposeBag = DisposeBag()
    
    var cities = [CityDTO]()
    var errorMessage: BehaviorSubject<String> = BehaviorSubject(value: "")
    var filteredCities: PublishSubject<[CityDTO]> = PublishSubject()
    var allCities: [CityDTO] = []
    var countyChosed: BehaviorSubject<String> = BehaviorSubject(value: "")
    var searchFilter: PublishSubject<String> = PublishSubject()
    var isCapital: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var minPopulation: BehaviorRelay<String?> = BehaviorRelay(value: "0")
    var maxPopulation: BehaviorRelay<String?> = BehaviorRelay(value: "0")
    var minTemperature: BehaviorRelay<String?> = BehaviorRelay(value: "0")
    var numOfSub = 0

    func fetchCities() {
        cityService
            .subscribe(onNext: { [weak self] cities in
                self?.cities = cities
            }, onError: { [weak self] error in
                self?.errorMessage.onNext("Error fetching cities: \(error)")
            })
            .disposed(by: disposeBag)
    }
   
    func toggleCapital()-> Bool {
        
        let currentState: Bool = try! isCapital.value()
        let newState = !currentState
        isCapital.onNext(newState)
        return newState
    }
   
    func applyFilters() {
        Observable.combineLatest(
            searchFilter,
            countyChosed,
            isCapital,
            minPopulation,
            maxPopulation,
            minTemperature
        ).do( // to check num of new subs
            onSubscribe: {
                self.numOfSub += 1
                print("New subscription. Total: \(self.numOfSub)")
            },
            onDispose: {
                self.numOfSub -= 1
                print("Subscription disposed. Total: \(self.numOfSub)")
            }
        )
        .subscribe(onNext: { (searchFilter, countyChosed, isCapital, minPopulation, maxPopulation, minTemperature) in
            
            let minPopulationInt = Int(minPopulation ?? "0") ?? 0
            let maxPopulationInt = Int(maxPopulation ?? "0") ?? 0
            let minTemperatureInt = Int(minTemperature ?? "0") ?? 0
            
            let filterCities =
            self.cities
                .filter({ countyChosed.isEmpty ? true : $0.country.lowercased().contains(countyChosed.lowercased()) })
                .filter({ searchFilter.isEmpty ? true : $0.city.lowercased().contains(searchFilter.lowercased()) })
                .filter({ !isCapital ? true : $0.capital == isCapital })
                .filter({ minPopulationInt <= 0 && maxPopulationInt <= 0 ? true : $0.population >= minPopulationInt && $0.population <= maxPopulationInt })
                .filter({ minTemperatureInt <= 0 ? true : $0.mostCommonTemp >= minTemperatureInt })
            
            self.filteredCities.onNext(filterCities)
            
        }).disposed(by: disposeBag)
    }
}
