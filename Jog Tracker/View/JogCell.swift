//
//  JogCell.swift
//  Jog Tracker
//
//  Created by Дмитрий Болоников on 7/5/19.
//  Copyright © 2019 Дмитрий Болоников. All rights reserved.
//

import UIKit

class JogCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(date: String, speed: String, distance: String, time: String) {
        dateLabel.text = date
        speedLabel.attributedText = makeAttributedString(withBoldKey: "Speed: ", andValue: speed)
        distanceLabel.attributedText = makeAttributedString(withBoldKey: "Distance: ", andValue: distance)
        timeLabel.attributedText = makeAttributedString(withBoldKey: "Time: ", andValue: time)
    }
    
    private func makeAttributedString(withBoldKey key: String, andValue value: String) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17)]
        let outputString = NSMutableAttributedString(string: key, attributes: attributes)
        let valueString = NSAttributedString(string: value)
        outputString.append(valueString)
        return outputString
    }

}
