
import UIKit

protocol NoContentBackground where Self: UIViewController {
    var tableView: UITableView! { get set }
    var backgroundView: TableBackgroundView { get }

    func showBackgroundView()
    func hideBackgroundView()
}

extension NoContentBackground {
    func showBackgroundView() {
        tableView.separatorStyle = .none
        self.tableView.backgroundView?.isHidden = false
    }

    func hideBackgroundView() {
        tableView.separatorStyle = .singleLine
        self.tableView.backgroundView?.isHidden = true
    }
}


