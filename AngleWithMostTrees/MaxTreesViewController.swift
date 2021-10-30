
//
//  ViewController.swift
//  AngleWithMostTrees
//
//  Created by Rita Asryan on 10/20/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//
import UIKit
import Foundation

struct PolarCoordinate: Equatable {
    var distance = 0.0
    var angle = 0.0
    
    static func ==(lhs: PolarCoordinate, rhs: PolarCoordinate) -> Bool {
        return lhs.distance == rhs.distance && lhs.angle == rhs.angle
    }
}

class MaxTreesViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var cameraWidthTextField: UITextField!
    @IBOutlet weak var treesCountLabel: UILabel!
    @IBOutlet weak var degreeTextField: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    @IBOutlet weak var forestView: CircleView!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var cameraAnglePositionLabel: UILabel!
    
    // MARK: - Properties
    var coordinates = [PolarCoordinate]()
    
    // MARK: - UIViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        registerForKeyboardNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        removeForKeyboardNotifications()
    }
    
    
    // MARK: - Methods
    func configUI() {
        distanceTextField.delegate = self
        degreeTextField.delegate = self
        cameraWidthTextField.delegate = self
    }
    
    func findAngleWithMostTrees(cameraWidth: Double, polarCoordinateTrees: [PolarCoordinate]) -> (Double, Int) {
        var sum = 0
        var maxSum = 0
        var cameraPos = 0.0
        var sortedAngles = findAndSortAngles(polorCoordinateTrees: polarCoordinateTrees)
        let n = sortedAngles.count
        var index = n
        var key0 = sortedAngles[0].0 + cameraWidth
        
        for i in 1..<n {
            if sortedAngles[i].0 > key0 {
                index = i
                key0 = sortedAngles[i].0
                break
            }
        }
        
        for i in 0..<index {
            sum += sortedAngles[i].1
        }
        maxSum = sum
        cameraPos = sortedAngles[0].0
        // add cyclic effect
        let x = sortedAngles[n-1].0 + cameraWidth
        for i in 0..<index {
            if x > 360 {
                if x - 360 > sortedAngles[i].0 {
                    sortedAngles.append((sortedAngles[i].0 + 360, sortedAngles[i].1))
                }
                else {
                    break
                }
            }
            else {
                break
            }
            
        }
        let m = sortedAngles.count
        var j = 0
        var endKey = 0.0
        for i in index...m {
            endKey = sortedAngles[j].0 + cameraWidth
            if i < m {
                if key0 > endKey { //} && endKey > sortedAngles[i].0{
                    sum -= sortedAngles[j].1
                    j += 1
                    key0 = sortedAngles[j].0
                }
            }
            if maxSum <= sum {
                maxSum = sum
                cameraPos = sortedAngles[j].0
            }
            if i < m {
                key0 = sortedAngles[i].0
                sum += sortedAngles[i].1
//                index += 1
            }
        }
      
        cameraAnglePositionLabel.text = "\(cameraPos)"
        treesCountLabel.text = "\(maxSum)"
        return (cameraPos, maxSum)
    }
    
    func findAndSortAngles(polorCoordinateTrees: [PolarCoordinate]) -> Array<(Double, Int)> {
        var angles: [Double] = []
//        for i in 0...polorCoordinateTrees.count - 1 {
//            if polorCoordinateTrees[i].distance >= 0 && polorCoordinateTrees[i].angle >= 0 {
//                angles.append(atan(polorCoordinateTrees[i].y / polorCoordinateTrees[i].x) * 180 / .pi)
//            } else if polorCoordinateTrees[i].x <= 0  {
//                angles.append(180 + atan(polorCoordinateTrees[i].y / polorCoordinateTrees[i].x) * 180 / .pi)
//            } else if polorCoordinateTrees[i].x >= 0 && polorCoordinateTrees[i].y <= 0  {
//                angles.append(360 + atan(polorCoordinateTrees[i].y / polorCoordinateTrees[i].x) * 180 / .pi)
//            }
//        }
        for i in 0...polorCoordinateTrees.count - 1 {
            angles.append(polorCoordinateTrees[i].angle)
        }
        return countReapets(array: angles)
    }
    
    func countReapets(array: [Double]) -> Array<(Double, Int)> {
        var counts: [Double: Int] = [:]
        array.forEach { counts[$0, default: 0] += 1 }
        return counts.sorted { $0.key < $1.key}
    }
    
    func addAngleShapeLayer(center: CGPoint, startAngle: CGFloat = 0, endAngle: CGFloat = CGFloat(Double.pi * 2), radius: CGFloat = 2, fillColor: UIColor, strokeColor: UIColor) -> CAShapeLayer {
        let anglePath = UIBezierPath()
        anglePath.move(to: center)
        anglePath.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        anglePath.close()
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = anglePath.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = 1.0
        return shapeLayer
    }
    
    func removeSublayer(_ layer: CAShapeLayer) {
        layer.removeFromSuperlayer()
    }
    
    func isValidData() -> Bool {
        if distanceTextField.text == "" {
            showAlertView(text: "please fill x coordinate")
            return false
        } else if degreeTextField.text == "" {
            showAlertView(text: "please fill y coordinate")
            return false
        }
        return true
    }
    
    func isValidAngle(_ value: Double ) -> Bool {
        if value >= 361 {
            return false
        }
        return true
    }
    
    // MARK: - IBActions
    @IBAction func calculateButtonAction(_ sender: UIButton) {
        let cameraWidth = Double(cameraWidthTextField?.text ?? "") ?? 0
        let center = CGPoint(x: forestView.bounds.width / 2, y: forestView.bounds.height / 2 )
        if cameraWidthTextField.text?.count == 0 {
            showAlertView(text: "Please fill camera field")
        }
        if !coordinates.isEmpty && isValidAngle(cameraWidth) {
            let cameraAngleAndTrees = findAngleWithMostTrees(cameraWidth: cameraWidth, polarCoordinateTrees: coordinates)
            let startAngle = -CGFloat(cameraAngleAndTrees.0).toRadians()
            let endAngle = startAngle - CGFloat(cameraWidth).toRadians()
            let shape = addAngleShapeLayer(center: center, startAngle: startAngle, endAngle: endAngle, radius: 100, fillColor: .clear, strokeColor: .lightGray)
            forestView.layer.addSublayer(shape)
            self.showAlertWithYesNo(title: "Would you like to try again?", shapeLayer: shape, button: sender)
        } else {
            showAlertView(text: "There is no tree", message: "please add tree")
        }
    }
    
    func convertPolarToRectangularCoordinates(r: Double, degree: Double) -> (Double, Double){
        let x = r * cos(degree * .pi / 180)
        let y = r * sin(degree * .pi / 180)
        return (x, y)
    }
    
    @IBAction func addTrees(_ sender: UIButton) {
        if isValidData() {
            let r = Double(distanceTextField?.text ?? "") ?? 0
            var degree = (Double(degreeTextField?.text ?? "") ?? 0)
            if degree > 360 {
                showAlertView(text: "The degree couldn't be more than 360")
            } else {
                if degree == 360 {
                    degree = 0
                }
                let coordinate = convertPolarToRectangularCoordinates(r: r, degree: degree)
                let x: CGFloat = CGFloat(coordinate.0)
                let y: CGFloat = -CGFloat(coordinate.1)
                let center = CGPoint(x: forestView.bounds.width / 2 + x, y: forestView.bounds.height / 2 + y)
                
                if pow(coordinate.0, 2) + pow(coordinate.1, 2) >= pow(100, 2) {
                    showAlertView(text: "Tree is outside of the forest.")
                } else if (coordinates.firstIndex(of: PolarCoordinate(distance: r, angle: degree)) ?? -1 >= 0) {
                    showAlertView(text: "Tree is already added.")
                } else {
                    coordinates.append(PolarCoordinate(distance: r, angle: degree))
                    distanceTextField.text = ""
                    degreeTextField.text = ""
                    let fillColor = UIColor(red: 30/255, green: 128/255, blue: 46/255, alpha: 1)
                    let shapeLayer = addAngleShapeLayer(center: center, fillColor: fillColor, strokeColor: fillColor)
                    forestView.layer.addSublayer(shapeLayer)
                }
            }
        }
    }
    
    // Move Up view with keyboard
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeForKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func keyboardWasShow(aNotification: Notification) {
        
        let kbSize = ((aNotification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue)?.size
        let duration: NSNumber = aNotification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
        let interval:TimeInterval = duration.doubleValue
        var contentInset = scrollView.contentInset
        contentInset.bottom = kbSize!.height
        scrollView.contentInset = contentInset
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentInset.bottom)
        scrollView.setContentOffset(bottomOffset, animated: false)
        UIView.animate(withDuration: interval, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func keyboardWillBeHidden(aNotification: Notification){
        
        let duration: NSNumber = aNotification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
        let interval:TimeInterval = duration.doubleValue
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        
        UIView.animate(withDuration: interval, animations: {
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - UITextField
extension MaxTreesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case cameraWidthTextField: distanceTextField.becomeFirstResponder()
        case distanceTextField: degreeTextField.becomeFirstResponder()
        case degreeTextField: degreeTextField.resignFirstResponder()
        default: break
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == cameraWidthTextField {
            if textField.text?.count == 0 && coordinates.isEmpty {
                cameraAnglePositionLabel.text = "0.0"
                treesCountLabel.text = "0"
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string == string.filter("0123456789-.".contains)
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}

extension UIViewController {
    func showAlertView(text: String, message: String = "") {
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithYesNo(title: String, message: String = "", shapeLayer: CAShapeLayer, button: UIButton) {
        let alert = UIAlertController(title: title, message:"", preferredStyle: .actionSheet)
        let yesAction = UIAlertAction(title: "Yes", style: .default) { (_) in
            shapeLayer.strokeColor = UIColor.clear.cgColor
        }
        let noAction = UIAlertAction(title: "No", style: .cancel) { (_) in
            button.isEnabled = false
            button.alpha = 0.5
        }
        alert.addAction(noAction)
        alert.addAction(yesAction)
        self.present(alert, animated: true, completion: nil)
    }
}
