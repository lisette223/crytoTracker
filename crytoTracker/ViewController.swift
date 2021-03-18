//
//  ViewController.swift
//  cryptoTracker
//
//  Created by Karan Gandhi on 3/9/21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var textField: UITextField!
    

    @IBOutlet weak var outputLabel: UILabel!
    
    
    
    
    @IBAction func buttonPressed(_ sender: Any) {
        
        
        if let symbol = textField.text {
            
            getData(symbol: symbol)
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }


    
    var url = "https://min-api.cryptocompare.com/data/price?tsyms=USD"
    
    //FOUNDATION ->
    
    func getData(symbol : String){
        
        
        url = "\(url)&fsym=\(symbol)"
        
        //Step 1: //Initialize the URL
        guard let url = URL(string: url) else {
            return
            
        }
        
        
        
        // Step 2 : initialized task and url session
        let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
            
      
            //Checking Optionals
            guard let data = data, error == nil else {return}
            
            print("Data Received!")
            //Grand Central Dispatch
            
            
//            //DISPATCH QUEUE aka a seperate thread
//
//            Threads -> |-------------------| {GCD}
//            |-------------|
//            |-----------|
//            |-------|
//            //sync   async
//            serial   concurrent
//
//            A B C
//
//            Serial :  A -> B -> C
//            Concurrent : A
//                         B
//                         C
//
//
//            Asynchronous :
//            A ---- --- End Time
//            B
//            C
//            Advantages :  Multiple Operations
//            Disadvantage : No time estimation
//
//            Synchronous :
//            A -> B -> C
//
//            Advantage -> TIME
//            TIme is a lot more
            
            do {
                
                let Result = try JSONDecoder().decode(APIResponse.self, from: data)
                print(Result.USD)
                
                DispatchQueue.main.async {
                    
                    self.outputLabel.text = "\(Result.USD)"
                    
                    
                }
                
            }
            
            catch {
                
                print(error.localizedDescription)
                
            }
            
            
            

            
        }
      //Step 3 : Task .Resume -> Initiate the process
        task.resume()
        
        
        
    }
    
    
    
    
    struct APIResponse : Codable {
        let USD : Float
        
    }
    
    
}


