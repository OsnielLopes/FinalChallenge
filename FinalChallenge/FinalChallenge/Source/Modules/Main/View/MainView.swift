//
//  MainView.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 29/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class MainView: UITabBarController, MainPresenterOutputProtocol {

    // MARK: - Viper Module Properties
    var presenter: MainPresenterInputProtocol!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.layer.shadowColor = UIColor(red: 18/255, green: 40/255, blue: 37/255, alpha: 1).cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.tabBar.layer.shadowRadius = 5
        self.tabBar.layer.shadowOpacity = 0.1
        self.tabBar.layer.masksToBounds = false
        
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().layer.borderColor = UIColor.clear.cgColor
    }
    
    // MARK: - MainPresenterOutputProtocol
    
    // MARK: - Private Methods
}
