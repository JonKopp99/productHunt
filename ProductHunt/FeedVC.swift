//
//  FeedVC.swift
//  ProductHunt
//
//  Created by Jonathan Kopp on 3/3/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import Foundation
import UIKit

class FeedVC: UIViewController {
    var backgroundImage = UIImageView()
    var feedTableView = UITableView()
    
    var posts: [Post] = [] {
        didSet {
            feedTableView.reloadData()
        }
    }
    
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        backgroundImage.image = #imageLiteral(resourceName: "blurredBackground")
        backgroundImage.frame = view.frame
        backgroundImage.contentMode = .scaleAspectFill
        self.view.addSubview(backgroundImage)
        feedTableView.dataSource = self
        feedTableView.delegate = self
        feedTableView.register(PostsCell.self, forCellReuseIdentifier: "postCell")
        feedTableView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        feedTableView.backgroundColor = .clear
        self.view.addSubview(feedTableView)
        
        updateFeed()
    }
    
    func updateFeed() {
        networkManager.getPosts() { result in
            switch result {
            case let .success(posts):
                print("Success")
                self.posts = posts
            case let .failure(error):
                print(error)
                print("Your a failure Jon")
            }
        }
    }
    
    
}

// MARK: UITableViewDataSource
extension FeedVC: UITableViewDataSource {
    /// Determines how many cells will be shown on the table view.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    /// Creates and configures each cell.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostsCell
        
        let post = posts[indexPath.row]
        cell.post = post
        cell.previewImageView.downloaded(from: post.previewImageURL)
        
        return cell
    }
}

// MARK: UITableViewDelegate
extension FeedVC: UITableViewDelegate {
    // Code to handle cell events goes here...
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        
        let VC = CommentsVC()
        VC.postID = post.id
        navigationController?.present(VC, animated: true, completion: nil)
        
        self.present(VC, animated: true, completion: nil)
        
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
