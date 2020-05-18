//
//  KeyboardMixin.swift
//  Mixin
//
//  Created by one on 30/11/2017.
//  Copyright © 2017 one. All rights reserved.
//

import UIKit

public protocol KeyboardMixin: ViewControllerMixinable {
    var keyboardHeight: CGFloat? { set get }
}

public extension KeyboardMixin {
    private func registerKeyboard() {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardHeight = nil
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: nil) { [weak self] notification in
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                self?.keyboardHeight = keyboardSize.height
            }
        }
    }
    private func deregisterKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    private func viewWillAppear(_ animated: Bool) {
        print("KeyboardMixin viewWillAppear")
        registerKeyboard()
    }
    private func viewWillDisappear(_ animated: Bool) {
        deregisterKeyboard()
    }
    public var viewControllerLifeCycle_KeyboardMixin: UIViewControllerLifeCycle {
        return BlockViewControllerLifeCycle(
            viewWillAppear: viewWillAppear,
            viewWillDisappear: viewWillDisappear
        )
    }
}
