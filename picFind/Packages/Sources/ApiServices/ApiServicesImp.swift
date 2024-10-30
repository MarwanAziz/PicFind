//
//  
//
//  Created by Marwan Aziz on 29/10/2024.
//

import Foundation

public struct ApiServicesImp: ApiServices {
  private let session: NetworkSession

  public init(session: NetworkSession = URLSession.shared) {
    self.session = session
  }

  internal func constructUrl(searchTerm: String) -> String {
    apiEndPoint + "?q_all=\(searchTerm)&q_type=\(allowedImageTypes)"
  }

  private func createUrlRequest(for searchTerm: String) -> URLRequest? {
    guard let url = URL(string: constructUrl(searchTerm: searchTerm)) else {
      return nil
    }
    var request = URLRequest(url: url)
    request.setValue("Client-ID \(cientID)", forHTTPHeaderField: "Authorization")
    return request
  }

  public func searchImages(searchTerm: String) async throws -> [ImageData] {
    guard let request = createUrlRequest(for: searchTerm) else {
      return []
    }
    let (data, response) = try await session.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
      throw NSError(domain: "Something went wrong!", code: -1, userInfo: nil)
    }
    let decodedResponse = try JSONDecoder().decode(ImgurSearchResponse.self, from: data)
    return decodedResponse.data?.flatMap { $0.images ?? [] } ?? []
  }
}
