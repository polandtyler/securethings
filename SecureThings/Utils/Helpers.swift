import Foundation

func isNoteLocked(lockStatus: LockStatus) -> Bool {
    return lockStatus == .locked ? true : false
}

func lockStatusFlipper(lockStatus: LockStatus) -> LockStatus {
    return lockStatus == .locked ? .unlocked : .locked
}
