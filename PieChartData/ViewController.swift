import UIKit

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Data for the pie chart
        let data = [
            PieChartData(value: 30, color: .red),
            PieChartData(value: 20, color: .green),
            PieChartData(value: 50, color: .blue)
        ]
        
        let pieChartView = PieChartView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        pieChartView.center = view.center
        view.addSubview(pieChartView)
        
        // Set the data for the pie chart
        pieChartView.data = data
    }
}

struct PieChartData {
    let value: CGFloat
    let color: UIColor
}

class PieChartView: UIView {
    
    var data: [PieChartData] = [] {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            print("Failed to get the current graphics context")
            return
        }
        
        let totalValue = data.reduce(0) { $0 + $1.value }
        var startAngle: CGFloat = -.pi / 2
        var endAngle = startAngle
        
        let centerX = bounds.width / 2
        let centerY = bounds.height / 2
        let radius = min(centerX, centerY)
        
        for pieData in data {
            endAngle += 2 * .pi * (pieData.value / totalValue)
            
            let path = UIBezierPath()
            path.move(to: CGPoint(x: centerX, y: centerY))
            path.addArc(withCenter: CGPoint(x: centerX, y: centerY),
                        radius: radius,
                        startAngle: startAngle,
                        endAngle: endAngle,
                        clockwise: true)
            path.close()
            
            pieData.color.setFill()
            path.fill()
            
            startAngle = endAngle
        }
    }
}
