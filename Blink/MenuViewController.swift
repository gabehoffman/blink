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
        case Testing1 = "Blink Testing (Questions)"
        case Testing2 = "Blink Testing (Results)"
        case Testing3 = "Blink Testing (Graphs)"
        case OneHundredMovements = "100 Movements"
    }
    
    var sections = [MenuSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMenu()
    }
    
    private func loadMenu() {
        
        let demoTestMenu1 = MenuItem(name: "Demo", storyboardID: "AssessmentViewController", dataFilename: "generic")
        let demoTestSection = MenuSection(sectionType: .Demo, items: [demoTestMenu1])
        
        let blinkTestMenu1 = MenuItem(name: "Questions w/ Generic Data", storyboardID: "QuestionListViewController", dataFilename: "generic")
        let blinkTestMenu2 = MenuItem(name: "Questions w/ Triangle Data", storyboardID: "QuestionListViewController", dataFilename: "triangleTest")
        let blinkTestMenu3 = MenuItem(name: "Questions w/ Hexagon Data", storyboardID: "QuestionListViewController", dataFilename: "hexagonTest")
        let blinkTestMenu5 = MenuItem(name: "Questions Data (Missing Key)", storyboardID: "QuestionListViewController", dataFilename: "generic")
        let blinkTestMenu6 = MenuItem(name: "Questions Data (Bad Type)", storyboardID: "QuestionListViewController", dataFilename: "generic")
        let blinkTestSection1 = MenuSection(sectionType: .Testing1, items: [blinkTestMenu1, blinkTestMenu2, blinkTestMenu3, blinkTestMenu5, blinkTestMenu6])
        
        let blinkTestMenu10 = MenuItem(name: "Results w/ Randomized Generic Data", storyboardID: "ResultListViewController", dataFilename: "genericRandomized")
        let blinkTestMenu11 = MenuItem(name: "Results w/ Randomized Triangle Data", storyboardID: "ResultListViewController", dataFilename: "triangleTest")
        let blinkTestMenu12 = MenuItem(name: "Results w/ Randomized Hexagon Data", storyboardID: "ResultListViewController", dataFilename: "hexagonTest")
        let blinkTestSection2 = MenuSection(sectionType: .Testing2, items: [blinkTestMenu10, blinkTestMenu11, blinkTestMenu12])
        
        let blinkTestMenu20 = MenuItem(name: "Graph Generic Data Demo", storyboardID: "MatrixViewController", dataFilename: "genericRandomized")
        let blinkTestMenu21 = MenuItem(name: "Graph Triangle Data Demo", storyboardID: "GraphViewController", dataFilename: "triangleTest")
        let blinkTestMenu22 = MenuItem(name: "Graph Hexagon Data Demo", storyboardID: "GraphViewController", dataFilename: "hexagonTest")
        let blinkTestSection3 = MenuSection(sectionType: .Testing3, items: [blinkTestMenu20, blinkTestMenu21, blinkTestMenu22])
        
        let oneHundredMenu1 = MenuItem(name: "100M Questions", storyboardID: "QuestionListViewController", dataFilename: "generic")
        let oneHundredMenu2 = MenuItem(name: "100M Questions (Missing Key)", storyboardID: "QuestionListViewController", dataFilename: "generic")
        let oneHundredMenu3 = MenuItem(name: "100M Questions (Bad Type)", storyboardID: "QuestionListViewController", dataFilename: "generic")
        let oneHundredMSection = MenuSection(sectionType: .OneHundredMovements, items: [oneHundredMenu1, oneHundredMenu2, oneHundredMenu3])
        
        self.sections = [demoTestSection, blinkTestSection1, blinkTestSection2, blinkTestSection3, oneHundredMSection]
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
        case .Demo, .Testing1, .Testing2, .Testing3, .OneHundredMovements:
            var vc = self.storyboard!.instantiateViewControllerWithIdentifier(menuItem.storyboardID) as! DataURLLoadable
            vc.dataURL = NSBundle.mainBundle().URLForResource(menuItem.dataFilename, withExtension: "json")
            showViewController(vc as! UIViewController, sender: self)
        }
    }
}
