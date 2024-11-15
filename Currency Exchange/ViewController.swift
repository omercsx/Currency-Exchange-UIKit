//
//  ViewController.swift
//  Currency Exchange
//
//  Created by Omer Cagri Sayir on 15.11.2024.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var conversionModel = CurrencyConversionModel()

    var fromIndex = 0
    var toIndex = 0

    // MARK: - Outlets

    @IBOutlet var fromAmount: UITextField!
    @IBOutlet var toAmount: UITextField!
    @IBOutlet var toCurrencyName: UILabel!
    @IBOutlet var fromCurrencyName: UILabel!
    @IBOutlet var currencyPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
    }

    // MARK: - UIPickerView Delegate and Datasource Methods

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return conversionModel.listOfCurrencies.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return conversionModel.listOfCurrencies[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 {
            fromIndex = row
        } else {
            toIndex = row
        }

        let fromCurrency = conversionModel.listOfCurrencies[fromIndex]
        let toCurrency = conversionModel.listOfCurrencies[toIndex]

        fromCurrencyName.text = conversionModel.currencyNames[fromCurrency]
        toCurrencyName.text = conversionModel.currencyNames[toCurrency]
        
        conversionModel.updateExchangeRate(self, fromCurrency, toCurrency)
    }
    
    func updateConvertedAmount(exchangeRate: Double) {
        toAmount.text = String(exchangeRate)
    }
}
