//
//  GFFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by mohamed ahmed on 02/10/2023.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
   private func configureItems(){
       itemInfoViewOne.set(itemInfoType: .followers, count: user.followers)
       itemInfoViewTwo.set(itemInfoType: .following, count: user.following)
       actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }

    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }

}
