//
//  TWTableViewCell.swift
//  TwitterFollowMap
//
//  Created by Julio Reyes on 4/9/21.
//

import UIKit

protocol FollowButtonsDelegate{
    func followButtonTapped(at index:IndexPath)
}

class TWTableViewCell: UITableViewCell {
    var delegate:FollowButtonsDelegate!
    var indexPath:IndexPath!
    var handle:TwitterModel! {
        didSet {
            self.textLabel?.text = handle?.twitterHandle
            if handle.isFollowing! {
                followBtn.setTitle("Following", for: .normal)
                followBtn.setTitleColor(.systemRed, for: .normal)
            }
        }
    }

    @IBOutlet weak var followBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
     @IBAction func followButton(_ sender: UIButton) {
        
        if !handle.isFollowing! {
            followBtn.setTitle("Followed", for: .normal)
            followBtn.setTitleColor(.systemRed, for: .normal)
        } else {
            followBtn.setTitle("Follow", for: .normal)
            followBtn.setTitleColor(.systemBlue, for: .normal)
        }

        self.delegate.followButtonTapped(at: indexPath)
     }
}
