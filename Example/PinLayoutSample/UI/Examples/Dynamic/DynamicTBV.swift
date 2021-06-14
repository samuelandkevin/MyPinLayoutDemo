//
//  DynamicTBV.swift
//  PinLayoutSample
//
//  Created by 黄坤鹏 on 2021/6/6.
//  Copyright © 2021 layoutbox. All rights reserved.
//

import Foundation

class DynamicTBV: UIView {
    
    private let tableView = UITableView()
    private let methodCellTemplate = DynamicCell()
    
    private var dataArray: [EHMessageModel] = []
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white

//        tableView.estimatedRowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .gray
        tableView.separatorStyle = .none
        tableView.register(DynamicCell.self, forCellReuseIdentifier: NSStringFromClass(DynamicCell.classForCoder()))
        addSubview(tableView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(dataArray: [EHMessageModel]) {
        self.dataArray = dataArray
        tableView.reloadData()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tableView.pin.all()
    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension DynamicTBV: UITableViewDataSource, UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(DynamicCell.classForCoder()), for: indexPath) as! DynamicCell
        cell.model = self.dataArray[indexPath.row]
        cell.onFoldBlock = { [weak self](obj)in
            guard let weakSelf = self else { return }
            if let path = tableView.indexPath(for: cell) {
                if path.row < weakSelf.dataArray.count {
                    let m = weakSelf.dataArray[path.row]
                    m.isOpening = !m.isOpening
                    tableView.reloadData()
                }
                
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // The UITableView will call the cell's sizeThatFit() method to compute the height.
        // WANRING: You must also set the UITableView.estimatedRowHeight for this to work.

        return UITableView.automaticDimension
    }
}
