//
//  CommentsVC.swift
//  ProductHunt
//
//  Created by Jonathan Kopp on 3/3/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class CommentsVC: UIViewController {
    
    var commentsTableView = UITableView()
    var backgroundImage = UIImageView()
    var comments: [Comment] = [] {
        didSet {
            commentsTableView.reloadData()
        }
    }
    
    var postID: Int!
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        backgroundImage.image = #imageLiteral(resourceName: "blurredBackground")
        backgroundImage.frame = view.frame
        backgroundImage.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImage)
        commentsTableView.backgroundColor = .clear
        commentsTableView.dataSource = self
        commentsTableView.delegate = self
        commentsTableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        commentsTableView.register(CommentCell.self, forCellReuseIdentifier: "commentCell")
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 100))
        let b = UIButton()
        b.frame = CGRect(x: self.view.bounds.width / 2  - 100, y: 60, width: 200, height: 40.0)
        b.titleLabel!.font = UIFont(name: "AvenirNext-DemiBold", size: 25)
        b.setTitle("Go Back", for: .normal)
        b.setTitleColor(#colorLiteral(red: 0.09029659377, green: 0.456161131, blue: 1, alpha: 1), for: .normal)
        b.titleLabel?.adjustsFontSizeToFitWidth = true
        b.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).withAlphaComponent(0.2)
        b.layer.cornerRadius = 20
        b.layer.borderWidth = 2
        b.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        b.addTarget(self, action:#selector(self.backPressed), for: .touchUpInside)
        headerView.addSubview(b)
        commentsTableView.tableHeaderView = headerView
        self.view.addSubview(commentsTableView)
        updateComments()
        
    }
    @objc func backPressed()
    {
        self.dismiss(animated: true, completion: nil)
    }
    func updateComments() {
        networkManager.getComments(postID) { result in
            switch result {
            case let .success(comments):
                self.comments = comments
                print("SUCCESS")
            case let .failure(error):
                print(error)
                print("YOUR A FAILURE JON")
            }
        }
    }
    
    
}

// MARK: UITableViewDataSource
extension CommentsVC: UITableViewDataSource {
    /// Determines how many cells will be shown on the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    /// Creates and configures each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        
        let comment = comments[indexPath.row]
        cell.commentTextView.text = comment.body
        return cell
    }
}

// MARK: UITableViewDelegate
extension CommentsVC: UITableViewDelegate {
    // Code to handle cell events goes here...
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
}
