//
//  MenuViewController.swift
//  Blink
//
//  Created by Gabe Hoffman on 2/12/16.
//  Copyright © 2016 Hoffman Tools. All rights reserved.
//

import UIKit

class MenuViewController : UITableViewController {
    
    struct MenuSection {
        let sectionType: SectionType
        let items: [MenuItem]
    }
    
    struct MenuItem {
        let name: String
        let storyboardID: String
        let dataFilename: String
    }
    
    enum SectionType: String {
        case Demo = "Demo Test"
        case Testing = "Blink (testing)"
        case OneHundredMovements = "100 Movements"
    }
    
    var sections = [MenuSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMenu()
    }
    
    private func loadMenu() {
        
        let demoTestMenu1 = MenuItem(name: "Demo", storyboardID: "DemoViewController", dataFilename: "generic")
        let demoTestSection = MenuSection(sectionType: .Demo, items: [demoTestMenu1])
        
        let blinkTestMenu1 = MenuItem(name: "Question Data Demo", storyboardID: "NativeWeatherViewController", dataFilename: "generic")
        let blinkTestMenu2 = MenuItem(name: "Question Data Demo (Missing Key)", storyboardID: "SwiftyJSONWeatherViewController", dataFilename: "generic")
        let blinkTestMenu3 = MenuItem(name: "Question Data Demo (Bad Type)", storyboardID: "FreddyWeatherViewController", dataFilename: "generic")
        let blinkTestSection = MenuSection(sectionType: .Testing, items: [blinkTestMenu1, blinkTestMenu2, blinkTestMenu3])
        
        let oneHundredMenu1 = MenuItem(name: "100M Questions", storyboardID: "FreddyMeetingListViewConroller", dataFilename: "generic")
        let oneHundredMenu2 = MenuItem(name: "100M Questions (Missing Key)", storyboardID: "FreddyMeetingListViewConroller", dataFilename: "generic")
        let oneHundredMenu3 = MenuItem(name: "100M Questions (Bad Type)", storyboardID: "FreddyMeetingListViewConroller", dataFilename: "generic")
        let oneHundredMSection = MenuSection(sectionType: .OneHundredMovements, items: [oneHundredMenu1, oneHundredMenu2, oneHundredMenu3])
        
        self.sections = [demoTestSection, blinkTestSection, oneHundredMSection]
    }
}

extension MenuViewController { // UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionType.rawValue
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let menuItem = sections[indexPath.section].items[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic", forIndexPath: indexPath)
        cell.textLabel!.text = menuItem.name
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = sections[indexPath.section]
        let menuItem = section.items[indexPath.row]
        switch section.sectionType {
        case .Demo, .Testing, .OneHundredMovements:
            var vc = self.storyboard!.instantiateViewControllerWithIdentifier(menuItem.storyboardID) as! DataURLLoadable
            vc.dataURL = NSBundle.mainBundle().URLForResource(menuItem.dataFilename, withExtension: "json")
            showViewController(vc as! UIViewController, sender: self)
        }
    }
}
