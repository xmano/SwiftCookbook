

enum CustomError: Error {
    case error01
}

func foo() throws {
    print("in foo")
    throw CustomError.error01
}

func bar() throws -> String {
    print("in bar")
    try foo()
    return "bar"
}

do {
    let result = try bar()
    print("result:", result)
} catch {
    print(error)
}

//prints
// in bar
// in foo
// error01
