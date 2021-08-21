//
//  ToggleSettingVC.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/20/21.
//

import Foundation
import UIKit

class ToggleSettingVC: BaseVC {
    let ktoggleCell = "ToggleCell"
    @IBOutlet weak var tableView: UITableView!
    var viewModel = ToggleVCViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: ktoggleCell, bundle: nil)
        self.tableView?.register(nib, forCellReuseIdentifier: ktoggleCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    func manageTheme() {
        self.view.backgroundColor = ThemeManager.shared.theme.backgroundColor
        self.tableView?.reloadData()
    }
}

extension ToggleSettingVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ktoggleCell,
                                                       for: indexPath) as? ToggleCell else {
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            cell.manageSettingsForTheme("Change Theme")
        } else {
            let model = viewModel.getUIModel(indexPath)
            cell.updateUI(model, indexPath)
            cell.delegate = self
        }
        return cell

    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if ThemeManager.shared.theme == .theme1 {
                ThemeManager.shared.applyTheme(theme: .theme2)
            } else {
                ThemeManager.shared.applyTheme(theme: .theme1)
            }
            manageTheme()
        }
    }
}
extension ToggleSettingVC: ToggleCellDelegate {
    func didSwitchChange(_ value: Bool, _ indexPath: IndexPath) {
        let model = viewModel.getUIModel(indexPath)
        model.isOn = value
    }
}
