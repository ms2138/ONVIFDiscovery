
import UIKit

protocol NoContentBackground where Self: UIViewController {
    var tableView: UITableView! { get set }
    var backgroundView: TableBackgroundView { get }
}


