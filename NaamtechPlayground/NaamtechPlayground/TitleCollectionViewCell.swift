//
//  TitleCollectionViewCell.swift
//  NaamtechPlayground
//
//  Created by Guxiaojie on 20/03/2018.
//  Copyright © 2018 SageGu. All rights reserved.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraint()
    }
    
    func setupViews() {
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.gray
        titleLabel.backgroundColor = UIColor(white: 1, alpha: 0.5)
        titleLabel.font = UIFont.systemFont(ofSize: 12)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraint() {
        //titleLabel
        let marginsDictionary = ["leftMargin": 10, "rightMargin": 10, "viewSpacing": 10]
        let viewsDictionary = ["title": titleLabel]
        let constraintTitleH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-leftMargin-[title]-rightMargin-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: marginsDictionary, views: viewsDictionary)
        contentView.addConstraints(constraintTitleH)
        let constrainttitleBottom = NSLayoutConstraint(item: titleLabel, attribute: .bottom, relatedBy: .equal, toItem: contentView, attribute: .bottom, multiplier: 1.0, constant: -10.0)
        contentView.addConstraint(constrainttitleBottom)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
    }

}
