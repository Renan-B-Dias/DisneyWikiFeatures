//
//  CharacterDetailsHeaderTableViewCell.swift
//  characterDetails
//
//  Created by Renan Benatti Dias on 21/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit
import Kingfisher

public protocol CharacterDetailsHeaderTableViewCellProtocol: BaseTableViewCell {
    
    var imageURL: URL? { get }
}

public struct CharacterDetailsHeaderTableViewCellModel: CharacterDetailsHeaderTableViewCellProtocol {
    
    public let imageURL: URL?
    
    public init(imageURL: URL?) {
        self.imageURL = imageURL
    }
}

public final class CharacterDetailsHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    private var viewModel: CharacterDetailsHeaderTableViewCellProtocol?

    public override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    public func bind(viewModel: CharacterDetailsHeaderTableViewCellProtocol) {
        
        characterImageView.kf.setImage(with: viewModel.imageURL)
        
        self.viewModel = viewModel
    }
    
    // Applylayout should be o base, don't you think?
    private func applyLayout() {
        // blur and stuff
    }
}
