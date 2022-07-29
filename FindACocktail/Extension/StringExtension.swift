//
//  StringExtension.swift
//  FindACocktail
//
//  Created by Vanda S. on 28/07/2022.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
}
