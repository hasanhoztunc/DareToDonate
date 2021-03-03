//
//  DonorViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 27.02.2021.
//

import Foundation
import RxDataSources

typealias DonorSectionModel = SectionModel<Int, DonorViewPresentable>

protocol DonorViewPresentable {
    
    var donorImage: UIImage { get }
    var donorName: String { get }
    var donorLocation: String { get }
    var donorBloodType: String { get }
}

struct DonorViewModel: DonorViewPresentable {
    
    var donorImage: UIImage
    var donorName: String
    var donorLocation: String
    var donorBloodType: String
}
