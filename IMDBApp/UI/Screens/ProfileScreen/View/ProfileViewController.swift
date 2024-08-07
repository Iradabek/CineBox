//
//  ProfileViewController.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 03.07.24.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SafariServices

class ProfileViewController: UIViewController {
    
    var vm = ProfileViewModel()
    var accountSettingList: [AccountSettingsTableViewCell.Item] = []
    
    private let tableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero, style: .grouped)
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tableView.register(AccountSettingsTableViewCell.self, forCellReuseIdentifier: AccountSettingsTableViewCell.identifier)
        tableView.backgroundColor = .primarySurface
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primarySurface
        navigationController?.navigationBar.isHidden = true
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
        
        vm.onUserDataFetch = { [weak self] in
            self?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview().inset(16)
        }
    }
}
/// - Data Source  Methods
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ProfileViewSections.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = ProfileViewSections.allCases[section]
        switch section {
        case .profile:
            return 1
        case .accountSettings:
            return 2
        case .helpAndSupport:
            return 3
        case .logOut:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let section = ProfileViewSections.allCases[indexPath.section]
        
        switch section {
        case .profile:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as! ProfileTableViewCell
                cell.configure(with: vm.username, email: vm.userEmail, profileImageName: vm.profileImageName)
            cell.selectionStyle = .none
            return cell
            
            
        case .accountSettings:
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSettingsTableViewCell.identifier, for: indexPath) as! AccountSettingsTableViewCell
            
            if indexPath.row == 0 {
                cell.configure(.init(titleText: "Watchlist", rightImage: "chevronRight"))
                cell.selectionStyle = .none
                cell.makeItTop()
                
            } else if indexPath.row == 1 {
                cell.configure(.init(titleText: "App Mode", rightImage: nil, isHideSeperator: true)) { isOn in
                    let newStyle: UIUserInterfaceStyle = isOn ? .dark : .light
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        windowScene.windows.forEach { window in
                            window.overrideUserInterfaceStyle = newStyle
                        }
                    }
                }
                cell.selectionStyle = .none
                cell.makeItBottom()
            }
            return cell
            
            
        case .helpAndSupport:
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSettingsTableViewCell.identifier, for: indexPath) as! AccountSettingsTableViewCell
            
            if indexPath.row == 0 {
                cell.configure(.init(titleText: "Privacy Policy", rightImage: "chevronRight"))
                cell.selectionStyle = .none
                cell.makeItTop()
                
            } else if indexPath.row == 1 {
                cell.configure(.init(titleText: "Terms & Conditions", rightImage: "chevronRight"))
                
            } else if indexPath.row == 2 {
                cell.configure(.init(titleText: "FAQ & Help", rightImage: "chevronRight", isHideSeperator: true))
                cell.selectionStyle = .none
                cell.makeItBottom()
                
            }
            return cell
            
        case .logOut:
            let cell = tableView.dequeueReusableCell(withIdentifier: AccountSettingsTableViewCell.identifier, for: indexPath) as! AccountSettingsTableViewCell
            cell.configure(.init(titleText: "Log Out", rightImage: "chevronRight", leftImage: "logout", isHideSeperator: true))
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 12
            return cell
        }
    }
}
/// - Delegate Methods
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = ProfileViewSections.allCases[indexPath.section]
        
        switch section {
        case .accountSettings:
            if indexPath.row == 0 {
                let watchListVC = WatchListViewController()
                navigationController?.pushViewController(watchListVC, animated: true)
            }
        case .helpAndSupport:
            let urls = [
                URL(string: "https://www.termsfeed.com/live/de9a999b-9b84-4cb8-9a6c-7200181e3f50"),
                URL(string: "https://www.termsfeed.com/live/c8be4cbc-576d-47e9-aa94-ed6bc46dc7cb"),
                URL(string: "https://developer.apple.com/help/app-store-connect/")
            ]
            if let url = urls[indexPath.row] {
                let safariVC = SFSafariViewController(url: url)
                self.present(safariVC, animated: true)
            }
            
        case .logOut:
            if indexPath.row == 0 {
                showLogoutAlert()
            }
        default:
            break
        }
    }
    
    private func showLogoutAlert() {
        let alert = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let logOutAction = UIAlertAction(title: "Log Out", style: .destructive) { _ in
            do {
                  try Auth.auth().signOut()
                  let loginVC = LoginViewController()
                  self.navigationController?.setViewControllers([loginVC], animated: true)
              } catch let signOutError as NSError {
                  print("Error signing out: %@", signOutError)
              }
          }
        
        alert.addAction(cancelAction)
        alert.addAction(logOutAction)
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = ProfileViewSections.allCases[section]
        switch sectionType {
        case .profile, .accountSettings, .helpAndSupport, .logOut:
            return ProfileSectionHeadersView(title: sectionType.sectionTitle)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionHeight = ProfileViewSections.allCases[section]
        switch sectionHeight {
        case .logOut, .profile:
            return 0
        default:
            return 32
        }
    }
}

