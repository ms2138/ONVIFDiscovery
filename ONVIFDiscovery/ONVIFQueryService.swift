
import Foundation

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
