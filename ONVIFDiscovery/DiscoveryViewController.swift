
import UIKit

class DiscoveryViewController: UITableViewController {
    private let reuseIdentifier = "DeviceCell"
    private var discoveredDevices = [ONVIFDiscovery]()
    private lazy var queryService = ONVIFQueryService()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension DiscoveryViewController {
    // MARK: - ONVIF Queries

    func getDevice(completion: @escaping (ONVIFDiscovery) -> Void) {
        do {
            try queryService.performONVIFDiscovery { (discoveredDevice, error) in
                if let error = error {
                    debugLog("Error: \(error)")
                }
                if let discoveredDevice = discoveredDevice {
                    completion(discoveredDevice)
                }
            }
        } catch {
            debugLog("Failed to perform UDP broadcast")
        }
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
