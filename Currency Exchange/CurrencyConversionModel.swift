//
//  CurrencyConversionModel.swift
//  Currency Exchange
//
//  Created by Omer Cagri Sayir on 15.11.2024.
//
import Foundation

class CurrencyConversionModel {
    var listOfCurrencies = ["USD", "EUR", "TRY", "GBP", "JPY", "CAD"]

    var currencyNames = [   "CAD": "Canadian Dollar",
                            "USD": "United States Dollar",
                            "EUR": "Euro",
                            "TRY": "Turkish Lira",
                            "GBP": "British Pound",
                            "JPY": "Japanese Yen"
                        ]
    
    let API_BASE_URL = "https://api.exchangeratesapi.io/v1/latest?access_key=6e8202ba3b24f80931a9b44ba11a4a77&"

    func updateExchangeRate(_ viewController: ViewController, _ fromCurrency: String, _ toCurrency: String) {
        // TODO: Implement the API call to get the exchange rate
        let apiUrl = "\(API_BASE_URL)base=\(fromCurrency)&symbols=\(toCurrency)"
        if let url = URL(string: apiUrl) {
            let dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
                if let dataReceived = data {
                    do {
                        let json = try JSON(data: dataReceived)
                        if let exchangeRate = json["rates"][toCurrency].double {
                            print(exchangeRate)
                            DispatchQueue.main.async {
                                viewController.updateConvertedAmount(exchangeRate: exchangeRate)
                            }
                        }

                    } catch let err {
                        print("Failed to create JSON object, \(err)")
                    }
                }
            }
            dataTask.resume()
        }
    }
}
