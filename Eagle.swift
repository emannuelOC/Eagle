import UIKit

extension UIViewController {
    
    override open func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            guard let window = UIApplication.shared.keyWindow,
                let view = window.rootViewController?.view else { return }
            let vc = EagleViewController(visibleView: view)
            let nav = UINavigationController(rootViewController: vc)
            
            window.rootViewController?.present(nav, animated: true, completion: nil)
        }
    }
    
    func 🦅() {
        guard let window = UIApplication.shared.keyWindow,
            let view = window.rootViewController?.view else { return }
        let vc = EagleViewController(visibleView: view)
        let nav = UINavigationController(rootViewController: vc)
        
        window.rootViewController?.present(nav, animated: true, completion: nil)
    }
    
}

class EagleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    var visibleView: UIView
    
    init(visibleView: UIView) {
        self.visibleView = visibleView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = String(describing: type(of: visibleView))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        let item = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissEagle))
        navigationItem.rightBarButtonItem = item
    }
    
    @objc func dismissEagle() {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return visibleView.subviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let view = visibleView.subviews[indexPath.row]
        if !view.subviews.isEmpty {
            cell.accessoryType = .disclosureIndicator
        } else {
            cell.accessoryType = .none
        }
        cell.textLabel?.text = String(describing: type(of: view))
        if let image = image(with: view) {
            cell.imageView?.image = image
            cell.imageView?.backgroundColor = .lightGray
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let view = visibleView.subviews[indexPath.row]
        if !view.subviews.isEmpty {
            let vc = EagleViewController(visibleView: view)
            navigationController?.show(vc, sender: nil)
        }
    }
    
    private func image(with view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
}
