//
//  Untitled.swift
//  RxSwiftCitiesDemo
//
//  Created by Haidy Saeed on 15/01/2025.
//
import RxSwift

class FilteredCitiesViewModel{
    
    var filterData: BehaviorSubject<[CityDTO]> = BehaviorSubject(value: [])

    init(filterData: [CityDTO]?) {
        self.filterData.onNext(filterData ?? []) 

    }
}
