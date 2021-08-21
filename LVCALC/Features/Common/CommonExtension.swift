//
//  CommonExtension.swift
//  LVCALC
//
//  Created by Mamta Sharma on 8/19/21.
//

import Foundation
import UIKit

protocol NibLoadableView: AnyObject { }

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
    static func viewFromNib() -> UIView? {
        let sliderView = Bundle.main.loadNibNamed(nibName, owner: self,
                                                  options: nil)?[0] as? UIView
        return sliderView
    }
}
protocol ReusableView: AnyObject {}
extension ReusableView where Self: UIView {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(forIndexPath
                                                    indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    func register<T: UITableViewCell>(_: T.Type) where T: ReusableView,
                                                       T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
}

extension UICollectionView {

    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath
                                                        indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView,
                                                            T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}

enum AppStoryboard: String {
    case main = "Main"

    var storyboard: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }

    func viewControllerFromStoryboard<T: UIViewController>(vco: T.Type) -> T {
        guard let viewController = storyboard.instantiateViewController(withIdentifier: vco.identifier) as? T else {
            fatalError()
        }
        return viewController
    }
}

extension UIViewController {

    class var identifier: String {
        return String(describing: self)
    }

   class func setupVCWithStoryBoardIdentifier(with storyboard: AppStoryboard) -> Self {
        let vco =  storyboard.viewControllerFromStoryboard(vco: self)
        return vco
    }
}
