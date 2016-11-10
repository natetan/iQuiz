//
//  QuestionModel.swift
//  iQuiz
//
//  Created by iGuest on 11/9/16.
//  Copyright © 2016 yulongproductions. All rights reserved.
//

import Foundation

public struct QuestionModel {
    
    public var title: String
    public var desc: String
    public var imageName: String
    
    init(title: String, desc: String, imageName: String) {
        self.title = title
        self.desc = desc
        self.imageName = imageName
    }
}
