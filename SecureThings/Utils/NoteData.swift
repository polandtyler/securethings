import Foundation

var note1 = Note(message: "This is a fun app to build.", lockStatus: .unlocked)
var note2 = Note(message: "Secure Notes is a really useful thing", lockStatus: .locked)
var note3 = Note(message: "Thanks, Apple!", lockStatus: .unlocked)
var note4 = Note(message: "TouchID is dope!", lockStatus: .unlocked)
var note5 = Note(message: "And I get FaceID for free? YES! 😍", lockStatus: .locked)

var notesArray: [Note] = [note1, note2, note3, note4, note5]
