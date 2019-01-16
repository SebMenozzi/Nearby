//
//  MenuController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 02/01/2019.
//  Copyright © 2019 Sebastien Menozzi. All rights reserved.
//

import UIKit

class MenuController: UITableViewController {
    
    let chatRoomsGroups = [
        ["France 🇫🇷", "Fun 🎉", "Food 🍎", "Seb", "Music 🎧", "ONPC 📺", "Seb 🔥", "Menozzi 🍩", "LVMH 🎉🎉"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .black
    }
    
    private class MenuHeaderLabel: UILabel {
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.insetBy(dx: 16, dy: 0))
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let text = section == 0 ? "MY ROOMS" : "UNDEFINED"
        
        let label = MenuHeaderLabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont(name: "GothamRounded-Medium", size: 16)
        label.backgroundColor = .black
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return chatRoomsGroups.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRoomsGroups[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MenuCell(style: .default, reuseIdentifier: nil)
        let text = chatRoomsGroups[indexPath.section][indexPath.row]
        cell.textLabel?.text = text
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        let attributeText = NSMutableAttributedString(string: "# ", attributes: [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .regular)
        ])
        attributeText.append(NSMutableAttributedString(string: text, attributes: [
            .foregroundColor: UIColor.white
        ]))
        cell.textLabel?.attributedText = attributeText
        return cell
    }
}
