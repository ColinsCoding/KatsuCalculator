//
//  ContentView.swift
//  KatsuCalculator
//
//  Created by Colin Casey on 6/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var resultText = "Result will be displayed here."
    
    var body: some View {
        VStack {
            Button("Test Communication") {
                testCommunication()
            }
            .padding()
            
            Text(resultText)
                .padding()
        }
        .padding()
    }
    
    func testCommunication() {
        guard let url = URL(string: "http://127.0.0.1:5000/test") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
                       let message = json["message"] {
                        DispatchQueue.main.async {
                            self.resultText = message
                        }
                    }
                } catch {
                    print("Error parsing JSON:", error)
                }
            } else if let error = error {
                print("Error:", error)
            }
        }.resume()
    }
}
