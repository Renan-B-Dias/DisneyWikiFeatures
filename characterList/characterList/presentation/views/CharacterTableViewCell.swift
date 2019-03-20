//
//  CharacterTableViewCell.swift
//  characterList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit

protocol CharacterTableViewCellProtocol {
    
    var name: String { get }
    var imageURL: URL? { get }
}

struct CharacterTableViewCellModel: CharacterTableViewCellProtocol {
    
    let name: String
    let imageURL: URL?
}

final class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private var viewModel: CharacterTableViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(viewModel: CharacterTableViewCellProtocol) {
        // kingfisher
        
        nameLabel.text = viewModel.name
        
        self.viewModel = viewModel
    }
}
