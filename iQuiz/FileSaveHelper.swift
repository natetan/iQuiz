//
//  FileSaveHelper.swift
//  iQuiz
//
//  Created by iGuest on 11/15/16.
//  Copyright © 2016 yulongproductions. All rights reserved.
//

import Foundation

class FileSaveHelper {
    
    //1
    // MARK:- Error Types
    private enum FileErrors:Error {
        case JsonNotSerialized
        case FileNotSaved
        
    }
    
    //2
    // MARK:- File Extension Types
    enum FileExension:String {
        case TXT = ".txt"
        case JPG = ".jpg"
        case JSON = ".json"
    }
    
    //3
    // MARK:- Private Properties
    private let directory:FileManager.SearchPathDirectory
    private var directoryPath: String = ""
    private let fileManager = FileManager.default
    private var fileName:String = ""
    private var filePath:String = ""
    private var fullyQualifiedPath:String = ""
    private var subDirectory:String = ""
    
    //1
    var fileExists:Bool {
        get {
            return fileManager.fileExists(atPath: fullyQualifiedPath)
        }
    }
    
    var directoryExists:Bool {
        get {
            var isDir = ObjCBool(true)
            return fileManager.fileExists(atPath: filePath, isDirectory: &isDir )
        }
    }
    
    //2
    init(fileName:String, fileExtension:FileExension, subDirectory:String, directory:FileManager.SearchPathDirectory){
        self.fileName = fileName + fileExtension.rawValue
        self.subDirectory = "/\(subDirectory)"
        self.directory = directory
        //3
        self.directoryPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true)[0]
        self.filePath = directoryPath + self.subDirectory
        self.fullyQualifiedPath = "\(filePath)/\(self.fileName)"
        //4
        print(self.directoryPath)
    }
    
}
