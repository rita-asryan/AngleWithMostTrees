//
//  ViewController.swift
//  AngleWithMostTrees
//
//  Created by Rita Asryan on 10/20/21.
//  Copyright © 2021 Rita Asryan. All rights reserved.
//
import UIKit
import Numerics


struct QuarterArrays {
    var quarter: Int
    var array: [Int]
}
struct ReapetCount {
    var Item: Int
    var count: Int
}

struct Coordinate {
    var x = 0
    var y = 0
}

class TestViewCodeController: UIViewController {
    
    var cameraWidth = 45

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var a =  countReapets(array: [4, 3, 5, 7, 4, 3, 3])
//        print(findAngles(polorCoordinateTrees: [Coordinate(1, 2), Coordinate(-1, 2), Coordinate(2, 2), Coordinate(-2, -2)]),
        let obj = Coordinate(x: 0, y: 1)
        print (findAngles(polorCoordinateTrees: [obj]))
        print(a)
    }


    
    func findAngleWithMostTrees(cameraWidth: Int, polorCoordinateTrees: [Coordinate]) {
      
}

    func findAngles(polorCoordinateTrees: [Coordinate]) -> [Int:Int] {
        var angles: [Int: Int] = [:]
        for i in 0...polorCoordinateTrees.count - 1 {
            if polorCoordinateTrees[i].y >= 0 {
                angles[0] = polorCoordinateTrees[i].y / polorCoordinateTrees[i].x   // first and second quarter
            } else {
                angles[1] = polorCoordinateTrees[i].y / polorCoordinateTrees[i].x   // third and fourth quarter
            }
        }
        return angles
    }
    
    func countReapets(array: [Int]) -> [Int:Int] {
        var counts: [Int: Int] = [:]
        array.forEach { counts[$0, default: 0] += 1 }
        return counts

    }

};
