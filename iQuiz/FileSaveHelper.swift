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
        createDirectory()
    }
    
    private func createDirectory(){
        //1
        if !directoryExists {
            do {
                //2
                try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: false, attributes: nil)
            }
            catch {
                print("An Error was generated creating directory")
            }
        }
    }
    
    //1
    func saveFile(string fileContents:String) throws{
        do {
            //2
            try fileContents.write(toFile: fullyQualifiedPath, atomically: true, encoding: String.Encoding.utf8)
        }
        catch  {
            //3
            throw error
        }
    }
    
    //1
    func saveFile(dataForJson dataForJson:AnyObject) throws{
        do {
            //2
            let jsonData = try convertObjectToData(data: dataForJson)
            if !fileManager.createFile(atPath: fullyQualifiedPath, contents: jsonData as Data, attributes: nil){
                throw FileErrors.FileNotSaved
            }
        } catch {
            //3
            print(error)
            throw FileErrors.FileNotSaved
        }
        
    }
    
    //4
    private func convertObjectToData(data:AnyObject) throws -> NSData {
        
        do {
            //5
            let newData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            return newData as NSData
        }
            //6
        catch {
            print("Error writing data: \(error)")
        }
        throw FileErrors.JsonNotSerialized
    }
    
}
