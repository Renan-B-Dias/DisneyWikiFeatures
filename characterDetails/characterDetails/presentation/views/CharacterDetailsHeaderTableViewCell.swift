//
//  CharacterDetailsHeaderTableViewCell.swift
//  characterDetails
//
//  Created by Renan Benatti Dias on 21/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit
import Kingfisher

protocol CharacterDetailsHeaderTableViewCellProtocol: BaseTableViewCell {
    
    var imageURL: URL? { get }
}

struct CharacterDetailsHeaderTableViewCellModel: CharacterDetailsHeaderTableViewCellProtocol {
    
    let imageURL: URL?
}

final class CharacterDetailsHeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    private var viewModel: CharacterDetailsHeaderTableViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        applyLayout()
    }
    
    func bind(viewModel: CharacterDetailsHeaderTableViewCellProtocol) {
        
        characterImageView.kf.setImage(with: viewModel.imageURL)
        
        self.viewModel = viewModel
    }
    
    // Applylayout should be o base, don't you think?
    private func applyLayout() {
        // blur and stuff
    }
}
