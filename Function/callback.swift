import Foundation


func getBoolValue(number : Int, completion: (Bool)->()) {
  if number > 5 {
    completion(true)
  } else {
   completion(false)
  }
}

getBoolValue(number : 8, completion:{ result in
  print(result)
})
