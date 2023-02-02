import Foundation
import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        setupTabBar()
        setupTabBarAppearance()
    }

    private func setupTabBar() {
        let dataSource: [TabBarItem] = [.add, .bill, .analytics]
        self.viewControllers = dataSource.map {
            switch $0 {
            case .add:
                let addController = AddViewController()
                    return self.wrappedInNavigationController(with: addController, title: $0.title)
            case .bill:
                let billController = BillViewController()
                    return self.wrappedInNavigationController(with: billController, title: $0.title)
            case .analytics:
                let analyticsController = AnalyticsViewController()
                    return self.wrappedInNavigationController(with: analyticsController, title: $0.title)
            }
        }
        
        self.viewControllers?.enumerated().forEach {
            $1.tabBarItem.title = dataSource[$0].title
            $1.tabBarItem.image = UIImage(systemName: dataSource[$0].iconName)
            //tabBar.tintColor = .red
            //tabBar.backgroundColor = .white
        }
    }
    
    private func wrappedInNavigationController(with: UIViewController, title: Any?) -> UINavigationController {
            return UINavigationController(rootViewController: with)
    }
    
    private func setupTabBarAppearance() {
        //для рисование кривых безье
        let positionOnX: CGFloat = 10
        let positionOnY: CGFloat = 14
        let width = tabBar.bounds.width - positionOnX * 2
        let height = tabBar.bounds.height + positionOnY * 2
        
        let roundLayer = CAShapeLayer()
        
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: positionOnX,
                                                          y: tabBar.bounds.minY - positionOnY,
                                                          width: width,
                                                          height: height),
                                                          cornerRadius: height / 2)
        
        roundLayer.path = bezierPath.cgPath
        tabBar.layer.insertSublayer(roundLayer, at: 0)
        tabBar.itemWidth = width / 5
        tabBar.itemPositioning = .centered
        roundLayer.fillColor = UIColor.white.cgColor
        tabBar.tintColor = .red
    }
    
    
    
}

private enum TabBarItem {
    case add
    case bill
    case analytics
   
    
    var title: String {
        switch self {
        case .add:
            return "Cчета"
        case .bill:
            return "Добавить"
        case .analytics:
            return "Аналитика"
        }
    }
    
    var iconName: String {
        switch self {
        case .add:
            return "wallet.pass.fill"
        case .bill:
            return "plus.circle.fill"
        case .analytics:
            return "ruler.fill"
        }
    }
}

