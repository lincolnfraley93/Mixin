//
//  ViewController.swift
//  Mixin
//
//  Created by Howard Yang on 12/03/2017.
//  Copyright (c) 2017 Howard Yang. All rights reserved.
//

import UIKit
import Mixin

class ViewController: UIViewController, ViewControllerMixinable, KeyboardMixin {
    var findTableView: UITableView? { return tableView }
    
    @IBOutlet weak var tableView: UITableView!
    
    var keyboardHeight: CGFloat? {
        didSet {
            tableView.contentInset.bottom = keyboardHeight ?? 0
        }
    }
    
    var fetchingMore = false
    var dataCount: Int = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        print("ViewController didSelectRowAt")
    }
}
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
}

public protocol NavigationBarHiding: ViewControllerMixinable {
  
}

public extension NavigationBarHiding {
  
  private func viewWillAppear(_ animated: Bool) {
    (self as? UIViewController)?.navigationController?.setNavigationBarHidden(true, animated: false)
  }
  private func viewWillDisappear(_ animated: Bool) {
    (self as? UIViewController)?.navigationController?.setNavigationBarHidden(true, animated: false)
  }
  
  var viewControllerLifeCycle_NavigationBarHiding: UIViewControllerLifeCycle {
      return BlockViewControllerLifeCycle(
          viewWillAppear: viewWillAppear,
          viewWillDisappear: viewWillDisappear
      )
  }
}

extension ViewController: NavigationBarHiding {}
