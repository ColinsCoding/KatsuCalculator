//
//  ContentView.swift
//  KatsuCalculator
//
//  Created by Colin Casey on 6/7/23.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = ""
    @State private var resultText = "Please enter the amount of chicken in grams."
    
    var body: some View {
        VStack {
            TextField("Enter amount in grams", text: $amount)
                .padding()
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button("Enter") {
                convertToKilograms()
            }
            .padding()
            
            Text(resultText)
                .padding()
        }
        .padding()
    }
    
    func convertToKilograms() {
        guard let url = URL(string: "http://127.0.0.1:5000/convert") else { return }
        guard let amountValue = Double(amount) else { return }
        
        let bodyData = ["amount": amountValue]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: bodyData, options: [])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let result = json["result"] {
                        DispatchQueue.main.async {
                            self.resultText = "Converted amount: \(result) kilograms"
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
