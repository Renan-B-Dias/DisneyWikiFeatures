//
//  MovieTableViewCell.swift
//  moviesList
//
//  Created by Renan Benatti Dias on 20/03/19.
//  Copyright © 2019 Renan Benatti Dias. All rights reserved.
//

import UIKit
import Kingfisher

protocol MovieTableViewCellProtocol {
    
    var posterURL: URL? { get }
    var name: String { get }
}

struct MovieTableViewCellModel: MovieTableViewCellProtocol {
    
    let posterURL: URL?
    let name: String
}

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(viewModel: MovieTableViewCellProtocol) {
        
        posterImageView.kf.setImage(with: viewModel.posterURL)
        nameLabel.text = viewModel.name
    }
}
