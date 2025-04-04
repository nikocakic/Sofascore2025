//
//  DataMapper.swift
//  Sofascore2025
//
//  Created by Niko on 26.03.2025..
//

import UIKit
import SnapKit
import SofaAcademic

enum DataMapper {
    
    static func imageUrlToUIImage(imageURL: String?) -> UIImage? {
        guard let imageURL = imageURL, let url = URL(string: imageURL) else { return nil }
        if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
            return image
        }
        return nil
    }
    
    

}
