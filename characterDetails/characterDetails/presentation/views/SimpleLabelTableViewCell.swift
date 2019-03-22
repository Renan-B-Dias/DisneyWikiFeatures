//
//  SimpleLabelTableViewCell.swift
//  characterDetails
//
//  Created by Renan Benatti Dias on 21/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit

protocol SimpleLabelTableViewCellProtocol: BaseTableViewCell {
    
    var id: Int? { get }
    var text: String { get }
    var font: UIFont { get }
}

struct SimpleLabelTableViewCellModel: SimpleLabelTableViewCellProtocol {
    
    let id: Int?    // Only for testing
    let text: String
    let font: UIFont
}

final class SimpleLabelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var simpleTextLabel: UILabel!
    
    private var viewModel: SimpleLabelTableViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        self.simpleTextLabel.numberOfLines = 0
    }
    
    func bind(viewModel: SimpleLabelTableViewCellProtocol) {
        
        self.simpleTextLabel.text = viewModel.text
        self.simpleTextLabel.font = viewModel.font
        
        self.viewModel = viewModel
    }
}
