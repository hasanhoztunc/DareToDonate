//
//  InfoCellViewModel.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 1.03.2021.
//
import RxDataSources

typealias InfoItemSectionModel = SectionModel<Int, InfoViewCellPresentable>

protocol InfoViewCellPresentable {
    var infoValue: String { get }
    var infoTitle: String { get }
}

struct InfoViewCellViewModel: InfoViewCellPresentable {
    
    let infoValue: String
    let infoTitle: String
}
