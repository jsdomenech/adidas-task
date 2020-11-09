//
//  PersistanceService.swift
//  adidas-task
//
//  Created by Jaime Domenech on 09/11/2020.
//
//  Decoupled PersitanceService by Protocol Composition
//  It will allow us to test it.
//

import Foundation

class PersistanceService {
    
    // MARK: Private
    
    private let fileManager: FileManagerCandidate
    private let dataManager: DataManagerCandidate
    
    // MARK: Lifecycle
    
    init(fileManager: FileManagerCandidate = FileManager.default,
         dataManager: DataManagerCandidate = DefaultDataManager()) {
        self.fileManager = fileManager
        self.dataManager = dataManager
    }
    
    // MARK: Persitance Errors
    
    enum Error: Swift.Error {
        case fileAlreadyExists
        case fileNotExists
        case invalidDirectory
        case writtingFailed
        case readingFailed
        case deletingFailed
    }
}

// MARK: Helper

private extension PersistanceService {
    
    private func makeURL(forFileNamed fileName: String) -> URL? {
        guard let url = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(fileName)
    }
}

// MARK: Public

extension PersistanceService {
    
    func save(fileNamed: String, data: Data) throws {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        do {
            try dataManager.write(data, to: url)
        } catch {
            throw Error.writtingFailed
        }
    }
    
    func read(fileNamed: String) throws -> Data {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        guard fileManager.fileExists(atPath: url.relativePath) else {
            throw Error.fileNotExists
        }
        do {
            return try dataManager.read(from: url)
        } catch {
            throw Error.readingFailed
        }
    }
    
    func delete(fileNamed: String) throws {
        guard let url = makeURL(forFileNamed: fileNamed) else {
            throw Error.invalidDirectory
        }
        guard fileManager.fileExists(atPath: url.relativePath) else {
            throw Error.fileNotExists
        }
        do {
            return try fileManager.removeItem(at: url)
        } catch {
            throw Error.deletingFailed
        }
    }
}

protocol DataManagerCandidate {
    
    func write(_ data: Data, to url: URL) throws
    func read(from: URL) throws -> Data
}

protocol FileManagerCandidate {
    
    func fileExists(atPath path: String) -> Bool
    func removeItem(at URL: URL) throws
    func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL]
    
}

struct DefaultDataManager: DataManagerCandidate {
    func write(_ data: Data, to url: URL) throws {
        try data.write(to: url)
    }
    
    func read(from url: URL) throws -> Data {
         try Data(contentsOf: url)
    }
}

extension FileManager: FileManagerCandidate {}
