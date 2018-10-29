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
    }
    
    // MARK: - MainPresenterOutputProtocol
    
    // MARK: - Private Methods
}
