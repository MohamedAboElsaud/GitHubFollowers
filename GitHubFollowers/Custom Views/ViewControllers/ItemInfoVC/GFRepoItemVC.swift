//
//  GFRepoItemVC.swift
//  GitHubFollowers
//
//  Created by mohamed ahmed on 02/10/2023.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureItems()
    }
    
   private func configureItems(){
       itemInfoViewOne.set(itemInfoType: .repos, count: user.publicRepos)
       itemInfoViewTwo.set(itemInfoType: .gists, count: user.publicGists)
       actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    override func actionButtonTapped() {
        delegate.didTapGitHubProfile(for: user)
    }

}
