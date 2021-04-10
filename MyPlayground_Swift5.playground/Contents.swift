import UIKit
import Foundation

// 1. A Standard Result Type

enum NetworkError: Error {
    case badURL
}

func fetchUnreadCount1(from urlString: String, completionHandler: @escaping (Result<Int, NetworkError>) -> Void) {
    guard let url = URL(string: urlString) else {
        completionHandler(.failure(.badURL))
        return
    }
    
    //complicated networking code here
    print("Fetching \(url.absoluteString)...")
    completionHandler(.success(5))
}

fetchUnreadCount1(from: "") { result in
    //There are several ways to handle Result enum
    
    //Way 1
    switch result {
    case .success(let count):
        print("\(count) unread messages.")
    case .failure(let error):
        print(error.localizedDescription)
    }
    
    //Way 2
    if let count = try? result.get() {
        print("\(count) unread messages.")
    }
    
    //Way 3
    _ = Result { try String(contentsOfFile: "someFile") }
}

// 2. Raw Strings Symbtol -> #
let rain = #"The "rain" in "Spain" falls mainly on the spaniards."#

//It treats backslash as being a literal character in the string, rather than an escape character.
let keypaths = #"Swift keypaths such as \Person.name hold uninvoked references to properties."#

// Here I have used \#(answer) to use string interpolation - a regular \(answer) will be interpreted as characters in the string, so when you want string interpolation to happen in a raw string you must add the extra #
let answer = 10
let rawStr = #"The answer is \#(answer)."#

//If you want to use # as part of string then..you need to start your string with ## and end with ##
let name = "Kirti"
let str = ##"My name is #### \#(name)" ####."##

//One more point is that Raw strings are fully compatible with Swift's multi-lie string.
//Also useful in reg-ex

let regex1 = "\\\\[A-Z]+[A-Za-z]+\\.[a-z]+" //Without Raw Strings
let regex2 = #"\\[A-Z]+[A-Za-z]+\.[a-z]+"# //With Raw Strings

// 3. Customizing String Interpolation
struct User {
    var name : String
    var age : Int
}

//In order to use USER object neatly, we can add string interpolation by adding extension to String.StringInterpolation with a new method appendInterpolation()
extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: User) {
        appendInterpolation("My name is \(value.name) and I'm \(value.age)")
    }
}

//Now, we can create a user and print out their data:
let user = User(name: "Kirti", age: 29)
print("User details: \(user)")

//Custom interpolation can take as many parameters as you need.
extension String.StringInterpolation {
    mutating func appendInterpolation(_ number: Int, style: NumberFormatter.Style) {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        
        if let result = formatter.string(from: number as NSNumber) {
            appendLiteral(result)
        }
    }
}


