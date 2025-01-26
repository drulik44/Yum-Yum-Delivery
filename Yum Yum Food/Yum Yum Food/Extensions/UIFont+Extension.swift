//
//  UIFont+Extension.swift
//  Yum Yum Food
//
//  Created by Руслан Жидких on 24.11.2024.
//

import UIKit

extension UIFont {
    enum Rubick {
        enum black {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.black, size: size)!
            }
        }
        enum blackItalic {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.blackItalic, size: size)!
            }
        }
        enum bold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.bold, size: size)!
            }
        }
        enum boldItalic {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.boldItalic, size: size)!
            }
        }
        enum extraBold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.extraBold, size: size)!
            }
        }
        enum extraBoldItalic {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.extraBoldItalic, size: size)!
            }
        }
        enum italic {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.italic, size: size)!
            }
        }
        enum light {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.light, size: size)!
            }
        }
        enum lightItalic {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.lightItalic, size: size)!
            }
        }
        enum medium {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.medium, size: size)!
            }
        }
        enum mediumItalic {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.mediumItalic, size: size)!
            }
        }
        enum regular {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.regular, size: size)!
            }
        }
        enum semibold {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.semibold, size: size)!
            }
        }
        enum semiboldItalic {
            static func size(of size: CGFloat) -> UIFont {
                return UIFont(name: Constants.Rubick.semiboldItalic, size: size)!
            }
        }
        
    }
    
}

private extension UIFont {
    enum Constants {
        enum Rubick {
            static let black = "Rubik-Black"
            static let blackItalic = "Rubik-BlackItalic"
            static let bold = "Rubik-Bold"
            static let boldItalic = "Rubik-BoldItalic"
            static let extraBold = "Rubik-ExtraBold"
            static let extraBoldItalic = "Rubik-ExtraBoldItalic"
            static let italic = "Rubik-Italic"
            static let light = "Rubik-Light"
            static let lightItalic = "Rubik-LightItalic"
            static let medium = "Rubik-Medium"
            static let mediumItalic = "Rubik-MediumItalic"
            static let regular = "Rubik-Regular"
            static let semibold = "Rubik-SemiBold"
            static let semiboldItalic = "Rubik-SemiBoldItalic"
        }
    }
}
