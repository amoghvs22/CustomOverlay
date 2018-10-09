import UIKit

@IBDesignable class CustomizeCircle: UIView {
    
    @IBInspectable public var circleRadius: CGFloat = 0
    
    @IBInspectable public var angle: Double = 90 { //0 to 360
        didSet {
            if angle >=  0 {
                setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable public var startAngle: Double = 0//0 to 360
    
    @IBInspectable public var innerCircleThickness: CGFloat = 0.5 //Between 0.1 to 1
    @IBInspectable var innerCircleColor: UIColor = UIColor.blue
    
    @IBInspectable public var outerCircleThickness: CGFloat = 0.5//Between 0.1 to 1
    @IBInspectable var outerCircleColor: UIColor = UIColor.orange
    @IBInspectable public var roundedCorners: Bool = false
    
    private enum Conversion {
        static func degreesToRadians (value:CGFloat) -> CGFloat {
            return value * .pi / 180.0
        }
        
        static func mod(value: Double, range: Double, minMax: (Double, Double)) -> Double {
            let (min, max) = minMax
            assert(abs(range) <= abs(max - min), "range should be <= than the interval")
            if value >= min && value <= max {
                return value
            } else if value < min {
                return mod(value: value + range, range: range, minMax: minMax)
            } else {
                return mod(value: value - range, range: range, minMax: minMax)
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        //Converting values to radians for inner circle
        let reducedAngle = Conversion.mod(value: angle, range: 360, minMax: (0, 360))
        let fromAngle = Conversion.degreesToRadians(value: CGFloat(-startAngle))
        let toAngle = Conversion.degreesToRadians(value: CGFloat(reducedAngle - startAngle))
        
        //Center for both circles
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        //Radius for both circles
        let radius: CGFloat = max(circleRadius - innerCircleThickness / 2, circleRadius - outerCircleThickness / 2)
        
        
        //Creating path for inner circle
        var path = UIBezierPath(arcCenter: center,
                                radius: radius/2 - innerCircleThickness/2,
                                startAngle: 0,
                                endAngle: .pi * 2,
                                clockwise: true)
        
        //Setting thickness inner circle
        path.lineWidth = circleRadius/4 * innerCircleThickness
        innerCircleColor.setStroke()
        path.stroke()
        
        
        //Creating path for outer circle
        path = UIBezierPath(arcCenter: center,
                            radius: radius/2 - outerCircleThickness/2,
                            startAngle: fromAngle,
                            endAngle: toAngle,
                            clockwise: true)
        
        //Setting thickness outer circle
        path.lineWidth = circleRadius/4 * outerCircleThickness
        outerCircleColor.setStroke()
        path.lineCapStyle = roundedCorners ? .round : .butt
        path.stroke()
    }
}
