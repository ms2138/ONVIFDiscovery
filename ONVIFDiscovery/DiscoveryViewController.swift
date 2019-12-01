
import UIKit

class DiscoveryViewController: UITableViewController {
    private let reuseIdentifier = "DeviceCell"
    private var discoveredDevices = [ONVIFDiscovery]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DiscoveryViewController {
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveredDevices.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let device = discoveredDevices[indexPath.row]
        cell.textLabel?.textColor = .darkText
        cell.textLabel?.text = device.model
        cell.detailTextLabel?.text = device.ipAddress
        cell.isUserInteractionEnabled = true

        return cell
    }
}
