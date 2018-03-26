import Foundation

class Note {
    public private(set) var message: String
    public var lockStatus: LockStatus
    
    init(message: String, lockStatus: LockStatus) {
        self.message = message
        self.lockStatus = lockStatus
    }
}
