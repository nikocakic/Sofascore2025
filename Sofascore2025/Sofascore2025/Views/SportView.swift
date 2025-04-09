//
//  SportView.swift
//  Sofascore2025
//
//  Created by Niko on 30.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

final class SportView: BaseView {
    
    private var imageView = UIImageView()
    private var sportName = UILabel()
    private var selectedIcon = UIImageView()
    
    var sportEnum: SportType?
    var isSelected: Bool?

    override func addViews() {
        addSubview(imageView)
        addSubview(sportName)
        addSubview(selectedIcon)
    }
    override func styleViews() {
        sportName.font = .robotoRegularSize14
        sportName.textColor = .whiteLabelColor
        
    }
    override func setupConstraints() {
        imageView.snp.makeConstraints{
            $0.size.equalTo(16)
            $0.top.equalToSuperview().inset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(sportName.snp.top).offset(-4)
        }
        
        sportName.snp.makeConstraints(){
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
        
        selectedIcon.snp.makeConstraints(){
            $0.height.equalTo(4)
            $0.width.equalTo(104)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sportName.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
        }
        
    }
    
    func setSelected(_ selected: Bool) {
        isSelected = selected
        selectedIcon.isHidden = !selected
    }
    func configure(with sport: SportLogoViewModel){
        sportEnum = sport.sportEnum
        imageView.image = sport.sportEnum.icon
        sportName.text = sport.sportEnum.name
        let iconName = "selectedIcon"
        selectedIcon.image = UIImage(named: iconName) ?? UIImage()
        isSelected = sport.isSelected
        setSelected(isSelected ?? false)
    }
    
}

