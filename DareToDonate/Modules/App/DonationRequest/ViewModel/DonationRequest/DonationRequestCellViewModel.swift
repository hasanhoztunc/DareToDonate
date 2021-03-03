//
//  DonationRequestViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 26.02.2021.
//

import Foundation
import RxDataSources

typealias DonationRequestItemSection = SectionModel<Int, DonationRequestCellViewPresentable>

protocol DonationRequestCellViewPresentable {
     
    var name: String { get }
    var location: String { get }
    var time: String { get }
    var bloodType: String { get }
}

struct DonationRequestCellViewModel: DonationRequestCellViewPresentable {
    
    var name: String
    var location: String
    var time: String
    var bloodType: String
}
