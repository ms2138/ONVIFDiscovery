
import Foundation
import SwiftyXMLParser

class ONVIFQueryService {
    let session: URLSession
    private var broadcastConnection: UDPBroadcastConnection!

    init() {
        self.session = URLSession(configuration: URLSessionConfiguration.ephemeral)
    }

    func performDataTask(for request: ONVIFRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        var urlRequest = URLRequest.init(url: request.url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = request.body

        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            completion(data, response, error)
        }
        task.resume()
    }
}

extension ONVIFQueryService {
    func performONVIFDiscovery(completion: @escaping (ONVIFDiscovery?, Error?) -> Void) throws {
        broadcastConnection = try UDPBroadcastConnection(
            port: 3702,
            handler: { (ipAddress, _, data) -> Void in
                var discoveredDevice: ONVIFDiscovery?
                let xml = XML.parse(data)
                let accessor = xml["s:Envelope", "s:Body", "d:ProbeMatches", "d:ProbeMatch"]
                // Get the url for the devices ONVIF service
                if let serviceURL = accessor["d:XAddrs"].url {
                    // Get the first scope where the ONVIF link contains hardware and then
                    // get the last path component that contains the devices model
                    if let hardwareScope = accessor["d:Scopes"].text?.split(separator: " ")
                        .first(where: { $0.contains("hardware") }),
                        let model = URL(string: String(hardwareScope))?.lastPathComponent {
                        discoveredDevice = ONVIFDiscovery(model: model,
                                                          ipAddress: ipAddress,
                                                          deviceService: serviceURL)
                    }
                }
                completion(discoveredDevice, nil)
        },
            errorHandler: { (error) in
                completion(nil, error)
        }
        )
        try broadcastConnection.sendBroadcast(generateBroadcastMessageTemplate())
    }
}

extension ONVIFQueryService {
    private func generateBroadcastMessageTemplate() -> String {
        return """
            <e:Envelope xmlns:e="http://www.w3.org/2003/05/soap-envelope"
                        xmlns:w="http://schemas.xmlsoap.org/ws/2004/08/addressing"
                        xmlns:d="http://schemas.xmlsoap.org/ws/2005/04/discovery"
                        xmlns:dn="http://www.onvif.org/ver10/network/wsdl">
                <e:Header>
                    <w:MessageID>uuid:84ede3de-7dec-11d0-c360-f01234567890</w:MessageID>
                    <w:To e:mustUnderstand="true">urn:schemas-xmlsoap-org:ws:2005:04:discovery</w:To>
                    <w:Action a:mustUnderstand="true">http://schemas.xmlsoap.org/ws/2005/04/discovery/Probe</w:Action>
                </e:Header>
                <e:Body>
                    <d:Probe>
                        <d:Types>dn:NetworkVideoTransmitter</d:Types>
                    </d:Probe>
                </e:Body>
            </e:Envelope>
        """
    }
}
