//
//  SimpleLabelTableViewCell.swift
//  characterDetails
//
//  Created by Renan Benatti Dias on 21/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit

public protocol SimpleLabelTableViewCellProtocol: BaseTableViewCell {
    
    var id: Int? { get }
    var text: String { get }
    var font: UIFont { get }
}

public struct SimpleLabelTableViewCellModel: SimpleLabelTableViewCellProtocol {
    
    public let id: Int?    // Only for testing
    public let text: String
    public let font: UIFont
    
    public init(id: Int?, text: String, font: UIFont) {
        self.id = id
        self.text = text
        self.font = font
    }
}

public final class SimpleLabelTableViewCell: UITableViewCell {
    
    @IBOutlet weak var simpleTextLabel: UILabel!
    
    private var viewModel: SimpleLabelTableViewCellProtocol?

    public override func awakeFromNib() {
        super.awakeFromNib()
        self.simpleTextLabel.numberOfLines = 0
    }
    
    public func bind(viewModel: SimpleLabelTableViewCellProtocol) {
        
        self.simpleTextLabel.text = viewModel.text
        self.simpleTextLabel.font = viewModel.font
        
        self.viewModel = viewModel
    }
}
