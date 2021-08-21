//
//  BaseVC.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/19/21.
//

import Foundation
import UIKit

class BaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = ThemeManager.shared.theme.backgroundColor
    }

}
