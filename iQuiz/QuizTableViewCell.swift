//
//  QuizTableViewCell.swift
//  iQuiz
//
//  Created by Yulong Tan on 11/3/16.
//  Copyright © 2016 yulongproductions. All rights reserved.
//

import UIKit

class QuizTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconImage.image = UIImage(named: "quiz-icon")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setImage(imageName: String) {
        iconImage.image = UIImage(named: imageName)
    }
    
}
