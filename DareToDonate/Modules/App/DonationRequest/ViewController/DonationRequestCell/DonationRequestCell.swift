//
//  DonationRequestCell.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 26.02.2021.
//

import UIKit

final class DonationRequestCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var bloodTypeLabel: UILabel!
    @IBOutlet private weak var donateButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        setupUI()
    }
    
    func configure(withViewModel viewModel: DonationRequestCellViewPresentable) {
        self.nameLabel.text = viewModel.name
        self.locationLabel.text = viewModel.location
        self.timeLabel.text = viewModel.time
        self.bloodTypeLabel.text = viewModel.bloodType
    }
    
    func setupUI() {
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        let margins = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        contentView.frame = contentView.frame.inset(by: margins)
        
        contentView.backgroundColor = .white
        
        contentView.cornerRadius = 10
        contentView.layer.shadowColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 0.1).cgColor
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = .zero
    }
}
