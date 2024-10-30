//
//  File.swift
//  
//
//  Created by Marwan Aziz on 29/10/2024.
//

import Foundation

public protocol NetworkSession {
  func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: NetworkSession {}
