//
//  MemeMeDrawView.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 26..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit

class MemeMeDrawView: UIView {

    var width : CGFloat = 1.0
    var Arr = [[path_struct]]()
    var pathArr = [path_struct]()
    
    //touch와 move를 확인하는 flag
    var biginFlag = false
    var moveFlag = false
    
    struct path_struct{
        var pathWidth : CGFloat = 1.0
        var pathPoint : CGPoint?
        var pathBeginPoint : CGPoint?
    }
    
    var pathEntity = path_struct()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        //현재 위치(Point) 얻어옴
        let point = touch.location(in: self)
        pathEntity.pathBeginPoint = point
        biginFlag = true //터치 완료
        
        // 다시 그리기
        self.setNeedsDisplay()
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        //현재 위치(Point) 얻어옴
        let point = touch.location(in: self)
        moveFlag = true //이동완료
        
        pathEntity.pathPoint = point
        pathEntity.pathWidth = width
        pathArr.append(pathEntity)
        
        // 다시 그리기
        self.setNeedsDisplay()
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //touch와 move 상태 확인
        if biginFlag, moveFlag {
            Arr.append(pathArr)
            pathArr.removeAll()
            
        }
        self.setNeedsLayout()
        biginFlag = false
        moveFlag = false
    }

    override func draw(_ rect: CGRect) {
        //하나 이상의 Beizerpath
        if Arr.count >= 1 {
            for i in Arr {
                let bez_path1 = UIBezierPath()
                bez_path1.move(to: i[0].pathBeginPoint!)
    
                for j in i {
                    bez_path1.lineWidth = j.pathWidth
                    bez_path1.addLine(to: j.pathPoint!)
                    bez_path1.stroke()
                }
                print("aaa")
            }
            
        }
        if pathArr.count < 1 {
            return
        }else{
            //현재 point 그림
            let bez_path1 = UIBezierPath()
            bez_path1.move(to: pathEntity.pathBeginPoint!)
            
            for i in pathArr {
                bez_path1.lineWidth = i.pathWidth
                bez_path1.addLine(to: i.pathPoint!)
                bez_path1.stroke()
            }
        }
        
    }
    
}
