//
//  DetailViewController.swift
//  LossLogbook
//
//  Created by Illia Rahozin on 27.08.2023.
//

import UIKit


class DetailViewController<T: Codable & TableRepresentable>: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - PROPERTIES
    var coordinator: DetailCoordinatorFlow?
    
    let data: [T]
    
    private lazy var infoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.register(OryxTableViewCell.self, forCellReuseIdentifier: OryxTableViewCell.identifier)
        tableView.allowsSelection = false

        
        return tableView
    }()
    
    // MARK: - LIFECYCLE
    
    init(data: [T]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        infoTableView.dataSource = self
        infoTableView.delegate   = self
        
        view.addSubview(infoTableView)
        infoTableView.fillSafeView(view)
    }
    
    // MARK: - CONFIGURE
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = data as? [EquipmentOryxJSON] {
            return data.count
        } else if let data = data.first {
            return data.propertyList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let fullEquipmentData = data as? [EquipmentOryxJSON] {
            let cell = tableView.dequeueReusableCell(withIdentifier: OryxTableViewCell.identifier, for: indexPath) as! OryxTableViewCell
            
            let data = fullEquipmentData[indexPath.row]
            cell.configure(img: data.equipmentUa.image, info: data.getDetailInfo())
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            if let property = data.first?.propertyList[indexPath.row] {
                if let value = property.value {
                    let formattedProperty = "\(property.key): \(value)"
                    cell.textLabel?.text = formattedProperty
                } else {
                    cell.textLabel?.text = "\(property.key): No data"
                }
            }
            
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let _ = data as? [EquipmentOryxJSON] {
            return 300
        } else {
            return 40
        }
    }
        
}


