//
//  ViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 31.10.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func drillingButtonPressed(_ sender: Any) {
        presentNextView(work: Work.drilling)
    }
    
    @IBAction func lathingButtonPressed(_ sender: Any) {
        presentNextView(work: Work.lathing)
    }
    
    @IBAction func millingButtonPressed(_ sender: Any) {
        presentNextView(work: Work.milling)
    }
    
    func presentNextView(work: Work){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let conditionView = storyboard.instantiateViewController(withIdentifier: "conditionView") as! ConditionViewController
        conditionView.work = work
        self.present(conditionView, animated: false, completion: nil)
    }
}

