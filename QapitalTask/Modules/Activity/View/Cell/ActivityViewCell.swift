//
//  ActivityViewCell.swift
//  QapitalTask
//
//  Created by Omima Ibrahim on 15/02/2021.
//

import UIKit

class ActivityViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configure(viewModel: ActivityViewModel) {    
        messageLabel.attributedText = viewModel.message.htmlAttributed(size: 16)
        dateLabel.text = viewModel.date
        amountLabel.text = viewModel.amount
    }
    
}
