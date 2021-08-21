//
//  ToggleCell.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/20/21.
//

import UIKit

protocol ToggleCellDelegate: AnyObject {
    func didSwitchChange(_ value: Bool,
                         _ indexPath: IndexPath)

}
class ToggleCell: UITableViewCell {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var switchUI: UISwitch!
    weak var delegate: ToggleCellDelegate?
    var indexPath: IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateUI(_ model: OperationModel, _ indexPath: IndexPath) {
        switchUI?.isHidden = false
        self.indexPath = indexPath
        titleLbl?.text = model.name
        switchUI?.isOn = model.isOn
        switchUI?.onTintColor = ThemeManager.shared.theme.switchStyle
        switchUI?.thumbTintColor = ThemeManager.shared.theme.smallViewColor
        titleLbl?.textColor = ThemeManager.shared.theme.titleTextColor

    }
    func manageSettingsForTheme(_ title: String) {
        titleLbl?.text = title
        switchUI?.isHidden = true
        titleLbl?.textColor = ThemeManager.shared.theme.titleTextColor
    }

    @IBAction func switchValueChanged(_ sender: UISwitch) {
        guard  let indexPath = self.indexPath, let isOn =  self.switchUI?.isOn else {
            return
        }
        delegate?.didSwitchChange(isOn, indexPath)
    }
}
