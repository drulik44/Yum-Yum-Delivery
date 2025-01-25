//
//  SectionOption.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 05.12.2024.
//

import Foundation

struct SectionOption{
    var name: String
    var icon: String
    var selected: Bool
}

 var paymentMethodData:[SectionOption] = [
    SectionOption(name: "Apple Pay", icon: "Apple Pay Icon",selected: false),
    SectionOption(name: "Cash".localized(), icon: "Cash Icons",selected: false),
    SectionOption(name: "Add debit/credit card".localized(), icon: "Plus",selected: false)
]
