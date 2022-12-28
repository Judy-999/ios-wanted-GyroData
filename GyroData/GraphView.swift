//
//  GraphView.swift
//  GyroData
//
//  Created by Judy on 2022/12/27.
//

import UIKit

class GraphView: UIView {
    private var segments = [GraphSegment]()
    private var currentSegment: GraphSegment? {
        return segments.last
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.black.cgColor
        self.backgroundColor = .systemBackground
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.drawGridGraph(in: self.bounds.size)
    }
    
    func add(_ motions: [Double]) {
        segments.forEach {
            $0.center.x += bounds.size.width / 600.0
        }
        
        addSegment()
        currentSegment?.add(motions)
    }
    
    // TODO: 모든 세그먼트와 그림 삭제하기
    func clearSegmanet() {
        
    }
    
    private func addSegment() {
        let startPoint: [Double]
        
        if let currentSegment = currentSegment {
            guard let lastPoint = currentSegment.dataPoints.last else { return }
            startPoint = lastPoint
        } else {
            startPoint = [0, 0, 0]
        }
        
        let segmentWidth = CGFloat(32)
        let newSegment = GraphSegment(startPoint: startPoint, segmentSize: bounds.size.width / 600.0)
        segments.append(newSegment)
        
        newSegment.backgroundColor = .clear
        newSegment.frame = CGRect(x: -segmentWidth, y: 0, width: segmentWidth, height: bounds.size.height)
        self.addSubview(newSegment)
    }
}

