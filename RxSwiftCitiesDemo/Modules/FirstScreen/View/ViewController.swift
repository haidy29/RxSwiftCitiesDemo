//
//  ViewController.swift
//  RxSwiftCitiesDemo
//
//  Created by Haidy Saeed on 14/01/2025.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController,UISearchBarDelegate {
    
    @IBOutlet weak var SeachTxt: UISearchBar!
    @IBOutlet weak var isCapitalBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var egyptBtn: UIButton!
    @IBOutlet weak var italyBtn: UIButton!
    @IBOutlet weak var usaBtn: UIButton!
    @IBOutlet weak var firstValueTxt: UITextField!
    
    @IBOutlet weak var tempTxt: UITextField!
    @IBOutlet weak var secondValueTxt: UITextField!
    
    private let disposeBag = DisposeBag()
    private let viewModel = CitiesViewModel()
    var filteredCities = [CityDTO]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SeachTxt.delegate = self
        viewModel.fetchCities()
        viewModel.applyFilters() //Move from OKbtn to here to reduce no of subscriptions
        bindViewModel()
    }
    
    func bindViewModel(){
        
        SeachTxt.rx.text.orEmpty
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] searchText in
                self?.viewModel.searchFilter.onNext(searchText)
            })
            .disposed(by: disposeBag)
        
        isCapitalBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.isCapitalBtn.backgroundColor = self.viewModel.toggleCapital() ? .green : .red
            
        }).disposed(by: disposeBag)
        
        
        Observable.merge(egyptBtn.rx.tap.map{"Egypt"},
                         italyBtn.rx.tap.map{"Italy"},
                         usaBtn.rx.tap.map{"USA"})
        .subscribe(onNext: { [weak self] country in
            guard let self = self else { return }
            
            self.egyptBtn.backgroundColor = .red
            self.italyBtn.backgroundColor = .red
            self.usaBtn.backgroundColor = .red
            
            self.viewModel.countyChosed.onNext(country)
            
            switch country {
            case "Egypt":
                self.egyptBtn.backgroundColor = .green
            case "Italy":
                self.italyBtn.backgroundColor = .green
            case "USA":
                self.usaBtn.backgroundColor = .green
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        firstValueTxt.rx.text.bind(to: viewModel.minPopulation).disposed(by: disposeBag)
        
        secondValueTxt.rx.text.bind(to: viewModel.maxPopulation).disposed(by: disposeBag)
        
        tempTxt.rx.text.bind(to: viewModel.minTemperature).disposed(by: disposeBag)
        
        okBtn.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.navigateToFilteredCities()
            })
            .disposed(by: disposeBag)
        
        viewModel.filteredCities
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] filteredCities in
                self?.filteredCities = filteredCities
            })
            .disposed(by: disposeBag)
    }
    func navigateToFilteredCities() {
        let st = UIStoryboard(name: "FilteredCities", bundle: nil)
        let vc = st.instantiateViewController(identifier: "FilteredCitiesViewController") as! FilteredCitiesViewController
        vc.viewModel = FilteredCitiesViewModel(filterData: filteredCities)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}






