//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by mohamed ahmed on 01/10/2023.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject{
    func didTapGitHubProfile(for user:User)
    func didTapGetFollowers(for user:User)
}
class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo  = UIView()
    let dataLabel = GFMessageLabel(textAlignment: .center)
    var itemViews : [UIView] = []
    
    var username: String!
    weak var delegate:FollowersListVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureViewController()
        layoutUI()
        getUserInfo()
        
        
    }
    func configureViewController(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let user):
                //                print(user)
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
        
    }
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func configureUIElements(with user: User){
        let repoItemVC = GFRepoItemVC(user: user)
        repoItemVC.delegate = self
        
        let followersItemVC = GFFollowerItemVC(user: user)
        followersItemVC.delegate = self
        
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followersItemVC, to: self.itemViewTwo)
        self.dataLabel.text = "GitHub Since \(user.createdAt.convertToDisplayFormat())"
        
    }
    func layoutUI(){
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        //        itemViewOne.backgroundColor = .systemPink
        //        itemViewTwo.backgroundColor = .systemBlue
        //        headerView.backgroundColor = .systemPink
        
        itemViews += [headerView , itemViewOne , itemViewTwo, dataLabel]
        
        for itemView in itemViews {
            
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
                itemView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
            ])
            
        }
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dataLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dataLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    func add(childVC: UIViewController , to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
        
    }
    
}
extension UserInfoVC : UserInfoVCDelegate{
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else{
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        presentSaafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
//
        guard user.followers != 0 else{
            presentGFAlertOnMainThread(title: "No followers", message: "The user has no followers 😔.", buttonTitle: "So sad")
            return
        }
        delegate.didRequestFollowers(for: user.login)
        dismissVC()
    }
    
    
    
}
