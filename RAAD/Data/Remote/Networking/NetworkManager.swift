//
//  NetworkManager.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation
protocol NetworkManagerProtocol {
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

final class NetworkManager:NetworkManagerProtocol {
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        
        var components = URLComponents(
                string: APIConstants.baseURL
                + endpoint.path
            )
        
        components?.queryItems = endpoint.queryItems
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
                
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200...299 ~= httpResponse.statusCode
        else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder()
            .decode(T.self, from: data)
    }
}
