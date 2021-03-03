//
//  HomeCollectionViewCell.swift
//  DareToDonate
//
//  Created by Hasan Oztunc on 25.02.2021.
//

import UIKit

final class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func configureCell(usingViewModel viewModel: CategoriesViewPresentable) {
        imageView.image = viewModel.image
        titleLabel.text = viewModel.title
    }
}

private extension CategoriesCollectionViewCell {
    
    func setupUI() {
        contentView.cornerRadius = 10
        contentView.layer.shadowColor = UIColor(red: 42/255, green: 42/255, blue: 42/255, alpha: 0.1).cgColor
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = .zero
    }
}
