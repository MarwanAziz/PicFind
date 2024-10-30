//
//  
//
//  Created by Marwan Aziz on 29/10/2024.
//

import Foundation
import XCTest
@testable import ApiServices

class ApiServicesTests: XCTestCase {
  var mockSession: MockNetworkSession!
  var apiService: ApiServicesImp!

  override func setUp() {
    super.setUp()
    mockSession = MockNetworkSession()
    apiService = ApiServicesImp(session: mockSession)
  }

  override func tearDown() {
    mockSession = nil
    apiService = nil
    super.tearDown()
  }

  private func makeMockData() -> Data {
    """
    {
        "data": [
            {
                "id": "MqxBfbx",
                "title": "Sample Image",
                "images": [
                    {
                        "id": "dAqZgRl",
                        "link": "https://i.imgur.com/dAqZgRl.jpg"
                    }
                ]
            }
        ],
        "success": true,
        "status": 200
    }
    """.data(using: .utf8)!
  }

  private func setupMockSession(with data: Data, statusCode: Int) {
    mockSession.data = data
    mockSession.response = HTTPURLResponse(
      url: URL(string: "https://api.imgur.com")!,
      statusCode: statusCode,
      httpVersion: nil,
      headerFields: nil
    )
  }

  func testSearchImages_Success() async throws {
    let mockData = makeMockData()
    setupMockSession(with: mockData, statusCode: 200)
    let images = try await apiService.searchImages(searchTerm: "test")
    XCTAssertEqual(images.count, 1)
    XCTAssertEqual(images.first?.link, "https://i.imgur.com/dAqZgRl.jpg")
  }

  func testSearchImages_Failure() async {
    mockSession.error = NSError(domain: "Network Error", code: -1, userInfo: nil)
    do {
      _ = try await apiService.searchImages(searchTerm: "test")
      XCTFail("Expected searchImages to throw an error, but it did not.")
    } catch {
      XCTAssertNotNil(error)
    }
  }
}
