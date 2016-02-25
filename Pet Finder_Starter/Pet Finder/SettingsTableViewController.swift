//
//  SettingsTableViewController.swift
//  Pet Finder
//
//  Created by Essan Parto on 5/16/15.
//  Copyright (c) 2015 Ray Wenderlich. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
  @IBOutlet weak var themeSelector: UISegmentedControl!
  @IBOutlet weak var applyButton: UIButton!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    themeSelector.selectedSegmentIndex = ThemeManager.currentTheme().rawValue
    
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Done, target: self, action: "dismiss")
  }
  
  func dismiss() {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  
  @IBAction func applyTheme(sender: UIButton) {
    
    if let selectedTheme = Theme(rawValue: themeSelector.selectedSegmentIndex){
        ThemeManager.applyTheme(selectedTheme)
    }
    
    dismiss()
  }
}
