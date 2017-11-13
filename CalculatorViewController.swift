//
//  ViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 31.10.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    var calculatorLogic = CalculatorLogic()
    
    var workOptions: [String] = ["Wähle den Arbeitsschritt","Bohren", "Drehen", "Fräsen"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background main area"))
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 95
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculatorLogic.cells.count
    }
  
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellToDisplay = calculatorLogic.cells[indexPath.row]
        
        switch cellToDisplay.celltype {
        case .descriptionLabel:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionLabel") as! DescriptionLabelCell
            cell.label.text = cellToDisplay.labeltext
            return cell
        case .buttonWhiteBig:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonWhiteBig") as! ButtonWhiteBigCell
            cell.label.text = cellToDisplay.labeltext
            return cell
        default:
            break
        }
       
        
        
        
        
        
        
        
        
        
//        if indexPath.row == 0 {
//             let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionLabel") as! DescriptionLabelCell
//
//            cell.label.text = workOptions[indexPath.row]
//            return cell
//        } else {
//             let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonWhiteBig") as! ButtonWhiteBigCell
//
//            cell.label.text = workOptions[indexPath.row]
//            return cell
//        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    

//    @IBAction func drillingButtonPressed(_ sender: Any) {
//        presentNextView(work: Work.drilling)
//    }
//
//    @IBAction func lathingButtonPressed(_ sender: Any) {
//        presentNextView(work: Work.lathing)
//    }
//
//    @IBAction func millingButtonPressed(_ sender: Any) {
//        presentNextView(work: Work.milling)
//    }
//
//    func presentNextView(work: Work){
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let conditionView = storyboard.instantiateViewController(withIdentifier: "conditionView") as! ConditionViewController
//        conditionView.work = work
//        self.present(conditionView, animated: false, completion: nil)
//    }
}

