//
//  FilteredCitiesViewController.swift
//  RxSwiftCitiesDemo
//
//  Created by Haidy Saeed on 15/01/2025.
//

import UIKit
import RxSwift
import RxCocoa

class FilteredCitiesViewController: UIViewController  {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: FilteredCitiesViewModel = FilteredCitiesViewModel(filterData: [])
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.filterData
            .bind(to: tableView.rx.items(cellIdentifier: "FilteredCitiesTableViewCell")) { (index, element, cell) in
                print(element.country)
                ( cell as? FilteredCitiesTableViewCell)?.lblCountry.text = element.country
                ( cell as? FilteredCitiesTableViewCell)?.lblCity.text = element.city
            }            .disposed(by: disposeBag)
    }
}

