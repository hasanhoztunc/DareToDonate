//
//  DonorCell.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 27.02.2021.
//

import UIKit

final class DonorCell: UITableViewCell {

    @IBOutlet private weak var donorImageView: UIImageView!
    @IBOutlet private weak var donorNameLabel: UILabel!
    @IBOutlet private weak var donorLocationLabel: UILabel!
    @IBOutlet private weak var donorBloodTypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupUI()
    }
    
    func configure(withViewModel viewModel: DonorViewPresentable) {
        self.donorImageView.image = viewModel.donorImage
        self.donorNameLabel.text = viewModel.donorName
        self.donorLocationLabel.text = viewModel.donorLocation
        self.donorBloodTypeLabel.text = viewModel.donorBloodType
    }
    
    func setupUI() {
        contentView.setShadow(color: .shadow)
        contentView.cornerRadius = 11
        
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let margins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        contentView.frame = contentView.frame.inset(by: margins)
    }
}
