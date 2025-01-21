//
//  FilteredCitiesTableViewCell.swift
//  RxSwiftCitiesDemo
//
//  Created by Haidy Saeed on 16/01/2025.
//

import UIKit
import RxSwift
import RxCocoa

class FilteredCitiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblCountry: UILabel!
    
    @IBOutlet weak var lblCity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
