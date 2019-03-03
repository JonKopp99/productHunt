//
//  CommentCell.swift
//  ProductHunt
//
//  Created by Jonathan Kopp on 3/3/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class CommentCell: UITableViewCell {
    
    
    var commentTextView = UITextView()
    
    
    override func layoutSubviews() {
        commentTextView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        commentTextView.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        commentTextView.backgroundColor = .clear
        commentTextView.font = UIFont(name: "AvenirNext-DemiBold", size: 15)
        //commentTextView.sizeToFit()
        backgroundColor = .clear
        addSubview(commentTextView)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
