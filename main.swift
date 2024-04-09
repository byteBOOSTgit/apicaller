/**
 APICaller
 Starter Swift code to call APIs from the command line.  This is best used for scripting.  This was developed with the help of AI and Googling.
 
 Author: Michael Miranda
 Date: 20240408
 */

import Foundation

let urlString: String = "https://itunes.apple.com/search?media=music&entity=song&term=harry connick"
// Step 1: Create a URL object with the API endpoint
guard let apiUrl = URL(string: urlString) else {
    print("Invalid API URL")
    exit(0)
}

// initiate a URLSession object
let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

// create a URLRequest
var request = URLRequest(url: apiUrl)
request.httpMethod = "GET" // use the applicable HTTP method (e.g., POST, PUT)

// may need to set http body for POST requests, etc.
//request.httpBody = Data()

// create a data task thread for the URL session
let task = session.dataTask(with: request) { data, response, error in
    // Check for Error
    if let error = error {
        print("Error: \(error.localizedDescription)")
        return
    }
    
    // ensure the response is a valid HTTP response
    guard let httpResponse = response as? HTTPURLResponse else {
        print("Invalid HTTP response")
        return
    }
    
    // verify the HTTP status code indicates success
    guard (200..<300).contains(httpResponse.statusCode) else {
        print("HTTP status code: \(httpResponse.statusCode)")
        return
    }

    // verify response data was received
    guard let responseData = data else {
        print("No data received")
        return
    }
   
    // for demo purposes, simply print the responseData as a string
    if let result = String(data: responseData, encoding: .utf8) {
        print(result)
    }
    // exit the runLoop thread once the task is complete
    exit(EXIT_SUCCESS)
}

// start the data task
task.resume()

// start a run loop which is needed for command line applications
// to ensure Task threads are executed until completion
print("Starting Run Loop...")
RunLoop.main.run()
