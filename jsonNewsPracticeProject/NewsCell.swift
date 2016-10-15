//
//  NewsCell.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 9/6/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import BEMCheckBox

class NewsCell: UICollectionViewCell {

    @IBOutlet weak var newsLogo: UIImageView!
    @IBOutlet weak var newsName: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var checkBox: BEMCheckBox!
}
