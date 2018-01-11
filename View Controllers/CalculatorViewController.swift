//
//  ViewController.swift
//  DrillMe
//
//  Created by Thomas Meinhart on 31.10.17.
//  Copyright © 2017 Thomas Meinhart. All rights reserved.
//

import UIKit
import iosMath

class CalculatorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate  {
    
    var calculatorLogic = CalculatorLogic()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sideBar: UICollectionView!
    weak var sideBarSelectedIndicator: CALayer!
    weak var alertSaveButton: UIAlertAction?
    weak var textFieldFavouriteName: UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "background main area"))
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 96
        
        let sideBarSelectedIndicator = CALayer()
        let image = #imageLiteral(resourceName: "sidebar selected indicator").cgImage!
        sideBarSelectedIndicator.contents = image
        sideBarSelectedIndicator.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 75, height: 75))
        sideBarSelectedIndicator.zPosition = -1
        sideBar.layer.insertSublayer(sideBarSelectedIndicator, at: 0)
        self.sideBarSelectedIndicator = sideBarSelectedIndicator
        
        
        let navigationBarTitle = UILabel()
        navigationBarTitle.text = "Drehzahlrechner"
        //navigationBarTitle.textColor = #colorLiteral(red: 0.216707319, green: 0.2553483248, blue: 0.2605955899, alpha: 1)
        let font = UIFont.systemFont(ofSize: 24, weight: .light)
        navigationBarTitle.font = font
        navigationItem.titleView = navigationBarTitle
        navigationItem.rightBarButtonItem = nil
        
    }
    
    @IBAction func tableTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.tableView)
        let path = self.tableView.indexPathForRow(at: location)
        if let indexPathForRow = path {
            self.tableView(self.tableView, didSelectRowAt: indexPathForRow)
        } else {
            let cell = tableView.cellForRow(at: IndexPath(row: 2, section: 0))
            if let textFieldCell = cell as? TextFieldWhite {
                textFieldCell.textField.resignFirstResponder()
            }
        }
    }
    
    //MARK: - TableView methods
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculatorLogic.cells.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cellDescriptionCellToDisplay = calculatorLogic.cells[indexPath.row]
        
        navigationItem.rightBarButtonItem = nil
        
        switch cellDescriptionCellToDisplay {
            case let cellDescription as CellDescriptionDescriptionLabel:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionLabel") as! DescriptionLabelCell
                cell.label.text = cellDescription.labelText
                return cell
            
            case let cellDescription as CellDescriptionWorkButton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonWhiteBigWithIcon") as! ButtonWhiteBigWithIconCell
                cell.label.text = cellDescription.labelText
                cell.icon.image = UIImage(named: cellDescription.iconName)
                return cell
            
            case let cellDescription as CellDescriptionCalculateButton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonBlackSmall") as! ButtonBlackSmall
                cell.label.text = cellDescription.labelText
                return cell
            
            case _ as CellDescriptionTextField:
                let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldWhite") as! TextFieldWhite
                cell.textField.becomeFirstResponder()
                return cell
            
            case let cellDescription as CellDescriptionConditionButton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ButtonWhiteBig") as! ButtonWhiteBigCell
                cell.label.text = cellDescription.labelText
                cell.descriptionLabel.text = cellDescription.descriptionText
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
                cell.rotationSpeedLabel.text = "= \(cellDescription.rotationSpeedLabel) U/min"
                cell.cuttingSpeedLabel.text = "= \(cellDescription.cuttingSpeedLabel) m/min"
                cell.diameterLabel.text = "= \(cellDescription.diameterLabel) mm"
                
                let formula = createFormulaLabel(cuttingSpeed: cellDescription.cuttingSpeedLabel, diameter: cellDescription.diameterLabel)

                //Delete formula from last calculation
                if !cell.formulaView.arrangedSubviews.isEmpty {
                    cell.formulaView.arrangedSubviews[0].removeFromSuperview()
                }
                
                cell.formulaView.addArrangedSubview(formula)
           
                return cell
            
            case _ as CellDescriptionRestartButton:
                let cell = tableView.dequeueReusableCell(withIdentifier: "RestartButton") as! RestartButton
                
                //Add Save To Favourites Button
                let button = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(saveToFavourites))
                button.title = "Speichern"
                button.tintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                navigationItem.rightBarButtonItem = button
                
                cell.addShadow()
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
                let textFieldDiameter = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextFieldWhite
                
                if textFieldDiameter.textField.text!.isEmpty {
                    let alert = UIAlertController(title: "Keinen Durchmesser eingegeben", message: "Gib einen Durchmesser ein", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    let diameter = NSString(string: textFieldDiameter.textField.text!).doubleValue
                    calculatorLogic.currentCalculation.diameter = diameter
                    calculatorLogic.currentCalculation.getRotationSpeedAndForwardSpeed()
                    calculatorLogic.setCellsForNextScreen()
                    tableView.reloadData()
                    sideBar.reloadData()
                }
                
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
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [], animations: ({
            self.sideBarSelectedIndicator.frame.origin.y = CGFloat(75*(self.calculatorLogic.sidebarItems.count-1))
        }), completion: nil)
    }
    
    //MARK: - IOSMath
    
    public func createFormulaLabel(cuttingSpeed: String, diameter: String) -> MTMathUILabel {
        let formulaLabel: MTMathUILabel = MTMathUILabel()
        formulaLabel.latex = "\\frac{1000 \\cdot \(cuttingSpeed)\\;m/min}{\(diameter)\\;mm \\cdot \\pi}"
        formulaLabel.fontSize = 20
        formulaLabel.textAlignment = MTTextAlignment.center
        formulaLabel.sizeToFit()
        return formulaLabel
    }
    
    //MARK: - TextField methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let decimalSeparator = ","
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
        if existingTextHasDecimalSeparator != nil, replacementTextHasDecimalSeparator != nil {
            return false
        } else {
            return true
        }
    }
    
    @IBAction func saveToFavourites(_ sender: Any) {
        
        let ac = UIAlertController(title: "Name für Favourit", message: "Gib einen Namen für den Favouriten ein:", preferredStyle: .alert)
        ac.addTextField(configurationHandler: {(textfield: UITextField) -> Void in
            textfield.placeholder = "Favouritenname"
            textfield.addTarget(self, action: #selector(self.checkTextFieldFavouriteName), for: .editingChanged)
            self.textFieldFavouriteName = textfield
        })
        
        let saveButton = UIAlertAction(title: "Speichern", style: .default, handler: {(alertAction: UIAlertAction) -> Void in
            self.calculatorLogic.currentCalculation.name = self.textFieldFavouriteName?.text
            Favourite.addNew(calculation: self.calculatorLogic.currentCalculation)

        })
        saveButton.isEnabled = false
        self.alertSaveButton = saveButton
        
        ac.addAction(saveButton)
        ac.addAction(UIAlertAction(title: "Abbrechen", style: .cancel, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
    
    @objc func checkTextFieldFavouriteName(_ sender: UITextField) {
        self.alertSaveButton?.isEnabled = !(sender.text ?? "").isEmpty
    }
    
}

extension UIView {
    func addShadow(offsetHeight: CGFloat = 5) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: offsetHeight)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 3
        clipsToBounds = false
    }
}
