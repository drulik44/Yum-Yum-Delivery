//
//  String+Extension.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 10.01.2025.
//

import Foundation

import Foundation

extension String {
    func localized() -> String {
        let languageCode = UserDefaults.standard.string(forKey: "AppLanguage") ?? Locale.current.language.languageCode?.identifier ?? "en"
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        let bundle = Bundle(path: path!)!
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: self, comment: self)
    }
}
