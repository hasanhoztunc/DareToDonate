//
//  HomeCell.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 1.03.2021.
//

import UIKit

final class InfoCell: UICollectionViewCell {
    
    @IBOutlet private weak var infoValueLabel: UILabel!
    @IBOutlet private weak var infoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func configure(withViewModel viewModel: InfoViewCellPresentable) {
        self.infoValueLabel.text = viewModel.infoValue
        self.infoTitleLabel.text = viewModel.infoTitle
    }
}

private extension InfoCell {
    
    func setupUI() {
        contentView.cornerRadius = 10
        contentView.setShadow(color: .shadow)
    }
}
