//
//  ViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 31.10.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    var calculatorLogic = CalculatorLogic()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideBar: UICollectionView!
    @IBOutlet weak var sideBarSelectedIndicator: UIImageView!
    
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
    
    
    //MARK: - TableView methods
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculatorLogic.cells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cellDescriptionCellToDisplay = calculatorLogic.cells[indexPath.row]
        
        switch cellDescriptionCellToDisplay {
            case let cellDescription as CellDescriptionDescriptionLabel:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionLabel") as! DescriptionLabelCell
                cell.label.text = cellDescription.labelText
                return cell
            
            case let cellDescription as CellDescriptionWorkButton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonWhiteBig") as! ButtonWhiteBigCell
                cell.label.text = cellDescription.labelText
                return cell
            
            case _ as CellDescriptionSeparator:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Separator") as! Separator
                return cell
            
            case let cellDescription as CellDescriptionCalculateButton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonBlackSmall") as! ButtonBlackSmall
                cell.label.text = cellDescription.labelText
                return cell
            
            case _ as CellDescriptionTextField:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldWhite") as! TextFieldWhite
                return cell
            
            case let cellDescription as CellDescriptionConditionButton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonWhiteBig") as! ButtonWhiteBigCell
                cell.label.text = cellDescription.labelText
                return cell
            
            case let cellDescription as CellDescriptionMaterialButton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonWhiteSmall") as! ButtonWhiteSmallCell
                cell.label.text = cellDescription.labelText
                return cell
            
            case let cellDescription as CellDescriptionWorkingStepButton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonWhiteSmall") as! ButtonWhiteSmallCell
                cell.label.text = cellDescription.labelText
                return cell
            
            case let cellDescription as CellDescriptionToolButton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonWhiteSmall") as! ButtonWhiteSmallCell
                cell.label.text = cellDescription.labelText
                return cell
            
            case let cellDescription as CellDescriptionResult:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Result") as! ResultCell
                cell.label.text = cellDescription.diameterLabel
                return cell
            
            case _ as CellDescriptionRestartButton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RestartButton") as! RestartButton
                return cell
            
            default:
                break
        }
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let  cellDescriptionCellSelected = calculatorLogic.cells[indexPath.row]
        
        switch cellDescriptionCellSelected {
            
            case let cellDescription as CellDescriptionWorkButton:
                calculatorLogic.currentCalculation.work = cellDescription.work
                calculatorLogic.setCellsForNextScreen()
                tableView.reloadData()
                sideBar.reloadData()
                
            
            case let cellDescription as CellDescriptionConditionButton:
                calculatorLogic.currentCalculation.condition = cellDescription.condition
                calculatorLogic.setCellsForNextScreen()
                tableView.reloadData()
                sideBar.reloadData()

            
            case let cellDescription as CellDescriptionWorkingStepButton:
                calculatorLogic.currentCalculation.workingStep = cellDescription.workingStep
                calculatorLogic.setCellsForNextScreen()
                tableView.reloadData()
                sideBar.reloadData()

            
            case let cellDescription as CellDescriptionToolButton:
                calculatorLogic.currentCalculation.tool = cellDescription.tool
                calculatorLogic.setCellsForNextScreen()
                tableView.reloadData()
                sideBar.reloadData()

            
            case let cellDescription as CellDescriptionMaterialButton:
                calculatorLogic.currentCalculation.material = cellDescription.material
                calculatorLogic.setCellsForNextScreen()
                tableView.reloadData()
                sideBar.reloadData()


            case _ as CellDescriptionCalculateButton:
                let textFieldDiameter = tableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! TextFieldWhite
                let diameter = NSString(string: textFieldDiameter.textField.text!).doubleValue
                calculatorLogic.currentCalculation.diameter = diameter
                calculatorLogic.currentCalculation.getRotationSpeedAndForwardSpeed()
                calculatorLogic.setCellsForNextScreen()
                tableView.reloadData()
                sideBar.reloadData()

            
            case _ as CellDescriptionRestartButton:
                calculatorLogic.restart()
                tableView.reloadData()
                sideBar.reloadData()

    
            default:
                break;
        }
    }
    
    //MARK: - CollectionView methods
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return calculatorLogic.sidebarItems.count
    }
   
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemToDisplay = calculatorLogic.sidebarItems[indexPath.row]
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "SideBarItem", for: indexPath) as! SidebarItem
        item.label.text = itemToDisplay.label
        item.icon.image = UIImage(named: itemToDisplay.icon)
        
        setSelectedIndicator()
        
        return item
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        
        calculatorLogic.returnToScreenAt(sideBarIndex: indexPath.row)
                
        tableView.reloadData()
        sideBar.reloadData()
    }
    
    func setSelectedIndicator(){
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: [], animations: ({
            self.sideBarSelectedIndicator.frame.origin.y = CGFloat(85*(self.calculatorLogic.sidebarItems.count-1))
        }), completion: nil)
    }
}

