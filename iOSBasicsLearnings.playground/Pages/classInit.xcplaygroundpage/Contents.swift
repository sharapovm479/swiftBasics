//: [Previous](@previous)

import Foundation


// class initilazer is a special method that set an initial value for each stored property on that instance and do any other setup or initialization that’s could reqrue before the new instance is ready for use. that improves encopsulatation,

// default initilizer
//1.Default Initilizer
//2.Memberwise Initilizer
//3.Custom Initilizer
//4.Failable Initilizer
//5. Convieince Initilizer
//Convenience initializers are used when you have some class with a lot of properties that make it kind of "Painful" to always initialize with all those variables, so what you do with convenience initializer is that you pass some of the variables to initialize the object, and assign the rest with a default value. There is a very good video on the Kodeco website, I'm not sure if it's free or not because I have a paid account. Here is an example where you can see that instead of initializing my object with all those variables I'm just giving it a title.

struct Scene {
  var minutes = 0
}

class Movie {
  var title: String
  var author: String
  var date: Int
  var scenes: [Scene]
  
  init(title: String, author: String, date: Int) {
    self.title = title
    self.author = author
    self.date = date
    scenes = [Scene]()
  }
  
  convenience init(title:String) {
    self.init(title:title, author: "Unknown", date:2016)
  }
  
  func addPage(page: Scene) {
    scenes.append(page)
  }
}


var myMovie = Movie(title: "my title") // Using convenicence initializer
var otherMovie = Movie(title: "My Title", author: "My Author", date: 12) // Using a long normal initializer
//6.Required Initilizer
