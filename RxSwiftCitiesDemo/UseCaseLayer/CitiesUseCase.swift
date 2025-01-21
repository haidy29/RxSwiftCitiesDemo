//
//  CitiesUseCase.swift
//  RxSwiftCitiesDemo
//
//  Created by Haidy Saeed on 15/01/2025.
//

import Foundation
import RxSwift
//protocol CityProtocol {
//    func getCities() -> Observable<[CityDTO]>
//}

class City {
    static var shared = City()
    func getCities() -> Observable<[CityDTO]> {
        return Observable.create { observer in
            if let jsonData = jsonString.data(using: .utf8) {
                let decoder = JSONDecoder()
                do {
                    let cities = try decoder.decode([CityDTO].self, from: jsonData)
                    observer.onNext(cities)
                    observer.onCompleted()
                } catch {
                    observer.onError(error)
                }
            } else {
                observer.onError(NSError(domain: "Invalid JSON String", code: -1, userInfo: nil))
            }
            
            return Disposables.create()
        }
    }
}
  
