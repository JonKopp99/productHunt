//
//  PostsCell.swift
//  ProductHunt
//
//  Created by Jonathan Kopp on 3/3/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class PostsCell: UITableViewCell {
    
    var nameLabel = UILabel()
    var taglineLabel = UILabel()
    var commentsCountLabel = UILabel()
    var votesCountLabel = UILabel()
    var previewImageView = UIImageView()
    
    var post: Post? {
        didSet {
            guard let post = post else { return }
            nameLabel.text = post.name
            taglineLabel.text = post.tagline
            commentsCountLabel.text = "Comments: \(post.commentsCount)"
            votesCountLabel.text = "Votes: \(post.votesCount)"
            updatePreviewImage()
        }
    }
    override func layoutSubviews() {
        nameLabel.frame = CGRect(x: 0, y: 0, width: frame.width / 2, height: 25)
        previewImageView.frame = CGRect(x: 0, y: 30, width: frame.width / 2, height: frame.height - 30)
        taglineLabel.frame = CGRect(x: frame.width / 2, y: 0, width: frame .width / 2, height: 30)
        votesCountLabel.frame = CGRect(x: frame.width / 2, y: 35, width: frame .width / 2, height: 30)
        commentsCountLabel.frame = CGRect(x: frame.width / 2, y: 70, width: frame .width / 2, height: 30)
        backgroundColor = .clear
        nameLabel.textColor = .white
        taglineLabel.textColor = .white
        taglineLabel.adjustsFontSizeToFitWidth = true
        votesCountLabel.textColor = .white
        commentsCountLabel.textColor = .white
        addSubview(nameLabel)
        addSubview(previewImageView)
        addSubview(taglineLabel)
        addSubview(votesCountLabel)
        addSubview(commentsCountLabel)
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
    
    func updatePreviewImage() {
        
        previewImageView.image = #imageLiteral(resourceName: "350x160")
    }
    
}
