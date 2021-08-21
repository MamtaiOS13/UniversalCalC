//
//  CalculatorVC.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/19/21.
//

import UIKit
import Reachability

class CalculatorVC: BaseVC, SetNameProtocal {

    let viewModel = CalculatorVCViewModel()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var outputLbl: UILabel!
    @IBOutlet var themeBtn: UIButton!
    @IBOutlet var topView: UIView!
    @IBOutlet var bottomView: UIView!
    @IBOutlet var landscapeTopView: UIView!
    @IBOutlet var landscapebBottomView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        outputLbl?.text = ""
        viewModel.currentDisplayValue = ""
        viewModel.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        manageTheme()
        manageSetting()
    }

    @IBAction func numberCLicked(_ sender: Any) {
        if let tag = (sender as AnyObject).tag {
            viewModel.performEnterNumer(tag)
        }
    }

    @IBAction func operationClicked(_ sender: Any) {
        print((sender as AnyObject).tag ?? 0)
        let currentOperation = (sender as AnyObject).tag ?? 0
        viewModel.performOperation(currentOperation)
    }

    @IBAction func actionBtnClicked(_ sender: Any) {
        print((sender as AnyObject).tag ?? 0)
        let currentAction = (sender as AnyObject).tag ?? 0
        viewModel.performActions(Actions(rawValue: currentAction) ?? .none)
    }

    func setDisplayText(_ text: String) {
        outputLbl?.text = text
    }

    func manageTheme() {
        self.view.backgroundColor = ThemeManager.shared.theme.backgroundColor
        self.outputLbl?.textColor = ThemeManager.shared.theme.titleTextColor
        self.topView?.backgroundColor = ThemeManager.shared.theme.smallViewColor
        self.bottomView?.backgroundColor =  self.topView?.backgroundColor
        self.landscapeTopView?.backgroundColor = ThemeManager.shared.theme.smallViewColor
        self.landscapebBottomView?.backgroundColor = self.landscapeTopView?.backgroundColor
    }

    func manageSetting() {
        let operationArray = AppSettings.shared.currentSetting.operationArray.filter({$0.isOn == false})
        for obj in operationArray {
            if let foundView = landscapeTopView?.viewWithTag(obj.tag.rawValue) {
                foundView.isHidden = true
            }
            if let foundView = bottomView?.viewWithTag(obj.tag.rawValue) {
                foundView.isHidden = true
            }
            if let foundView = topView?.viewWithTag(obj.tag.rawValue) {
                foundView.isHidden = true
            }
            if let foundView = landscapebBottomView?.viewWithTag(obj.tag.rawValue) {
                foundView.isHidden = true
            }
        }
        let visibleSet = AppSettings.shared.currentSetting.operationArray.filter({$0.isOn == true})
        for obj in visibleSet {

            if let foundView = landscapeTopView?.viewWithTag(obj.tag.rawValue) {
                foundView.isHidden = false
            }
            if let foundView = bottomView?.viewWithTag(obj.tag.rawValue) {
                foundView.isHidden = false
            }
            if let foundView = topView?.viewWithTag(obj.tag.rawValue) {
                foundView.isHidden = false
            }
            if let foundView = landscapebBottomView?.viewWithTag(obj.tag.rawValue) {
                foundView.isHidden = false
            }
        }
    }

    @IBAction func openSettingScreen(_ sender: Any) {
        let vco = ToggleSettingVC.setupVCWithStoryBoardIdentifier(with: .main)
        self.navigationController?.pushViewController(vco, animated: true)
    }

    @IBAction func onlineAction(_ sender: Any) {
        if Utility.isReachable() == true {
            if outputLbl?.text?.trimmingCharacters(in: NSCharacterSet.whitespaces).count ?? 0 > 0 {
                viewModel.checkExchange(outputLbl?.text ?? "") { [weak self] (result: Result<Double, Error>) in
                    DispatchQueue.main.async {
                        self?.didUpdateResponse(result: result)
                    }
                }

            } else {
                Utility.showApiError(title: "Alert", mess: "Please Enter value")
            }
        }
    }
    func didUpdateResponse(result: Result<Double, Error>) {
        switch result {
        case .success(let response):
            viewModel.currentDisplayValue = "\(String(describing: response))"
        case .failure(let error):
            Utility.showApiError(title: "Error", mess: error.localizedDescription)
        }
    }

}
