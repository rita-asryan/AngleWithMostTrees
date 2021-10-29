
//
//  ViewController.swift
//  AngleWithMostTrees
//
//  Created by Rita Asryan on 10/20/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//
import UIKit
import Foundation

//struct Coordinate {
//    var x = 0
//    var y = 0
//}
//
//class TestCodeViewController: UIViewController {
//
//    var pi = Double.pi
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        print(findAngleWithMostTrees(cameraWidth: 45, polarCoordinateTrees: [Coordinate(x: 1, y: 2), Coordinate(x: 2, y: 4), Coordinate(x: 1, y: 1), Coordinate(x: -2, y: 1), Coordinate(x: -4, y: 4), Coordinate(x: 2, y: 3), Coordinate(x: 6, y: 5), Coordinate(x: 1, y: -2)]))
//    }
//
//    func findAngleWithMostTrees(cameraWidth: Double, polarCoordinateTrees: [Coordinate]) -> (Double, Int) {
//        var sum = 0
//        var maxSum = 0
//        var cameraPos = 0.0
//        var sortedAngles = findAndSortAngles(polorCoordinateTrees: polarCoordinateTrees)
//        let n = sortedAngles.count
//        var index = n
//        var key0 = sortedAngles[0].0 + cameraWidth
//        
//        for i in 1..<n {
//            if sortedAngles[i].0 >= key0 {
//                index = i
//                break
//            }
//        }
//        
//        for i in 0..<index {
//            sum += sortedAngles[i].1
//        }
//        // add cyclic effect
//        if index < n {
//            sortedAngles.append(contentsOf: sortedAngles[0..<index])
//        }
//        
//        for i in index..<n+index-1 {
//            if maxSum < sum {
//                maxSum = sum
//                cameraPos = sortedAngles[i-index].0
//            }
//            maxSum = max(maxSum, sum)
//            key0 += sortedAngles[i].0
//            sum += sortedAngles[i].1
//            if key0 > sortedAngles[i-index].0 + cameraWidth {
//                key0 -= sortedAngles[i-index].0
//                sum -= sortedAngles[i-index].1
//            }
//        }
//        return (cameraPos, maxSum)
//
//    }
//
//    func findAndSortAngles(polorCoordinateTrees: [Coordinate]) -> Array<(Double, Int)> {
//        var angles: [Double] = []
//        for i in 0...polorCoordinateTrees.count - 1 {
//
//            if polorCoordinateTrees[i].x >= 0 && polorCoordinateTrees[i].y >= 0 {
//                angles.append(atan(polorCoordinateTrees[i].y / polorCoordinateTrees[i].x) * 180 / pi)
//            } else if polorCoordinateTrees[i].x <= 0  {
//                angles.append(180 + atan(polorCoordinateTrees[i].y / polorCoordinateTrees[i].x) * 180 / pi)
//            } else if polorCoordinateTrees[i].x >= 0 && polorCoordinateTrees[i].y <= 0  {
//                angles.append(360 + atan(polorCoordinateTrees[i].y / polorCoordinateTrees[i].x) * 180 / pi)
//            }
//        }
//        return countReapets(array: angles)
//
//    }
//
//    func countReapets(array: [Double]) -> Array<(Double, Int)> {
//        var counts: [Double: Int] = [:]
//        array.forEach { counts[$0, default: 0] += 1 }
//        return counts.sorted { $0.key < $1.key}
//    }
//}
