//
//  EventCell.swift
//  Sofascore2025
//
//  Created by Niko on 31.03.2025..
//


import UIKit
import SnapKit
import SofaAcademic

final class EventCell: UITableViewCell {
    
    static let identifier = "EventCell"
    
    private var eventView : EventView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        eventView = EventView()
        contentView.addSubview(eventView)
        
        eventView.snp.makeConstraints(){
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set (event: EventViewModel){
        eventView.configure(with: event)
    }
}
