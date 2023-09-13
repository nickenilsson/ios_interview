//
//  UIImageView+loadFromURL.swift
//  Interview
//
//  Created by niknil01 on 2022-11-29.
//

import UIKit

// Superbasic bildhämtning. Inte en del av "testet"
extension UIImageView {
    func load(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
