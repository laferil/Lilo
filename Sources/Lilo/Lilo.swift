import Foundation
import UIKit

public enum BackgroundStyle {
    case solid(UIColor)
    case translucent(UIColor)
}

public enum LoaderStyle {
    case solid(UIColor)
}

public enum CornerStyle {
    case circle
    case rounded(CGFloat)
    case squared
}

fileprivate let BACKGROUND_TAG = 343434

public class Lilo {
    public static func show(loaderStyle: LoaderStyle = .solid(.systemBackground), cornerStyle: CornerStyle = .rounded(16), backgroundStyle: BackgroundStyle = .translucent(.black), width: CGFloat = 75, height: CGFloat = 75, animated: Bool = true) {
        DispatchQueue.main.async {
            let window = UIApplication.shared.windows.first!
            guard window.subviewWith(tag: BACKGROUND_TAG) == nil else { return } // Prevent duplicating the overlay if we are already showing
            
            // Create background
            let backgroundView = UIView()
            backgroundView.tag = BACKGROUND_TAG
            backgroundView.alpha = 0
            backgroundView.translatesAutoresizingMaskIntoConstraints = false
            
            // Background styling
            switch backgroundStyle {
            case .solid(let color):
                backgroundView.backgroundColor = color
            case .translucent(let color):
                backgroundView.backgroundColor = color.withAlphaComponent(0.2)
            }
            window.addSubview(backgroundView)
            
            NSLayoutConstraint.activate([
                backgroundView.topAnchor.constraint(equalTo: window.topAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: window.bottomAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: window.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: window.trailingAnchor),
            ])
            
            // Create loader
            let frame = CGRect(x: 0, y: 0, width: width, height: height)
            let loaderView = UIView(frame: frame)
            loaderView.translatesAutoresizingMaskIntoConstraints = false
            
            // Loader styling
            switch loaderStyle {
            case .solid(let color):
                loaderView.backgroundColor = color
            }
            
            // Corner styling
            switch cornerStyle {
            case .circle:
                loaderView.layer.cornerRadius = width/2
            case .rounded(let radius):
                loaderView.layer.cornerRadius = radius
            case .squared:
                loaderView.layer.cornerRadius = 0
            }
            
            let activityIndicator = UIActivityIndicatorView(style: .medium)
            activityIndicator.color = .secondaryLabel
            activityIndicator.startAnimating()
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            loaderView.addSubview(activityIndicator)
            backgroundView.addSubview(loaderView)
                        
            NSLayoutConstraint.activate([
                NSLayoutConstraint(item: loaderView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: width),
                NSLayoutConstraint(item: loaderView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height),
                loaderView.centerXAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.centerXAnchor),
                loaderView.centerYAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: loaderView.safeAreaLayoutGuide.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: loaderView.safeAreaLayoutGuide.centerYAnchor),
            ])
            
            if animated {
                UIView.animate(withDuration: 0.3) {
                    backgroundView.alpha = 1
                }
            } else {
                backgroundView.alpha = 1
            }
        }
    }
    
    public static func hide(animated: Bool = true) {
        DispatchQueue.main.async {
            let window = UIApplication.shared.windows.first!
            guard let backgroundView = window.subviewWith(tag: BACKGROUND_TAG) else { return }
            
            if animated {
                UIView.animate(withDuration: 0.3) {
                    backgroundView.alpha = 0
                    backgroundView.removeFromSuperview()
                }
            } else {
                backgroundView.alpha = 0
                backgroundView.removeFromSuperview()
            }
        }
    }
}

fileprivate extension UIWindow {
    func subviewWith(tag: Int) -> UIView? {
        let window = UIApplication.shared.windows.first!
        for subview in window.subviews {
            if subview.tag == tag {
                return subview
            }
        }
        return nil
    }
}
