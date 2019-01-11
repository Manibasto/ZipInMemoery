//
//  ViewController.swift
//  testPractices
//
//  Created by Anilkumar on 10/09/18.
//  Copyright © 2018 Anilkumar. All rights reserved.
//

import UIKit
import Alamofire
import Gzip
import Zip
extension FileManager {
    class var documentsDirectory:URL? {
        return self.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
    
    class func url(for name:String) -> URL? {
        return documentsDirectory?.appendingPathComponent(name)
    }
    
    class func urls(for savedJPEGImage:String) -> URL? {
        return url(for: savedJPEGImage)
    }
}

class ViewController: UIViewController {
    
    var ZipdataImage = String()
    @IBOutlet var abc: UIButton!
    @IBOutlet var webViews: UIWebView!
    var zipdata = Data()
     var zipdataM = NSMutableData()
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = UIImage(named: "abi")
        let data = image?.jpegData(compressionQuality: 1.0)
        do{
            zipdata = try (data!.gzipped(level: .defaultCompression))
            print(zipdata)
        }
        catch let error{
            print(error)
        }
            let url = "https://bugs.dev-client.id-pal.com/toyota/api/checkzip_inmemory"
            Alamofire.upload(multipartFormData: { (multipartFormData) in
              //  let data = self.ZipdataImage.data(using: .utf8)
                multipartFormData.append(self.zipdata, withName: "zipfile", fileName: "ManiMaran.gz", mimeType: "application/zip")
            }, to:url)
            { (result) in
                switch result {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (Progress) in
                        print("progressing")
                        if (upload.uploadProgress.fractionCompleted == 1.0) {
                        }
                    })
                    upload.responseJSON { response in
                        
                        print(response.response)
                         print(response.result)

                        switch response.result
                        {
                            
                        case .failure(let error):
                            if let data = response.data {
                                print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                            }
                            print(error)
                            
                        case .success(let value):
                            
                            print(value)
                        }
                       
                    }
                case .failure(_): break
                   

                }
            }


    }
    
    func randomString(length: Int) -> String {
        let date = Date()
        let calendar = Calendar.current
        let minutes = calendar.component(.minute, from: date)
        let hour = calendar.component(.hour, from: date)
        let day = calendar.component(.day, from: date)
        let week = calendar.component(.weekday, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let letters = "\(hour)\(minutes)\(day)\(week)\(month)\(year)abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" //abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789
        return String((0...length-1).map{ _ in letters.randomElement()! })
    }
    @IBAction func genertate(_ sender: Any) {
        let uuid = randomString(length: 32)
        print(uuid)
        
        let image = UIImage(named: "test")
        let data = image?.jpegData(compressionQuality: 1.0)
        do{
            zipdata = try (data!.gzipped(level: .defaultCompression))
            print(zipdata)
            
            
        }
        catch let error{
            print(error)
        }
        let url = "https://bugs.dev-client.id-pal.com/toyota/api/checkzip_inmemory"
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            //  let data = self.ZipdataImage.data(using: .utf8)
            multipartFormData.append(self.zipdata, withName: "zipfile", fileName: "HK1.gz", mimeType: "application/zip")
        }, to:url)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (Progress) in
                    if (upload.uploadProgress.fractionCompleted == 1.0) {
                    }
                })
                upload.responseJSON { response in
                    
                    print(response.response)
                    print(response.result)
                    
                    switch response.result
                    {
                        
                    case .failure(let error):
                        if let data = response.data {
                            print("Print Server Error: " + String(data: data, encoding: String.Encoding.utf8)!)
                        }
                        print(error)
                        
                    case .success(let value):
                        
                        print(value)
                    }
                    
                }
            case .failure(_): break
                
                
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func camelcase(s: String) -> Int {
        var fullName = s
        
        var output = [String]()
        for chr in fullName {
            var str = String(chr)
            if str.lowercased() != str {
                let fullNameArr = fullName.components(separatedBy: str)
                fullName = fullNameArr.last!
                output.append(fullName)
            }
        }
        return output.count + 1
    }
    
    func compareTriplets(a: [Int], b: [Int]) -> [Int] {
        var a1 = [Int]()
        var b1 = [Int]()
        for var i in (0..<a.count){
            if a[i] > b[i]{
                a1.append(a[i])
            }else if a[i] < b[i]{
                b1.append(a[i])
            }
        }
        return [a.count,b.count]
        
    }
    
    func diagonalDifference(arr: [[Int]]) -> Int {
        // read the integer n
        var n = Int(readLine()!)!
        // declare 2d array
        var arr : [[Int]] = []
        
        // read array row-by-row
        for index in 0..<n {
            arr.append(readLine()!.characters.split(separator: " ",maxSplits: 5,omittingEmptySubsequences: true).map{Int(String($0))!})
        }
        var preimaryDiagonalSum = 0
        var secondaryDiagonalSum = 0
        for index in 0..<n {
            preimaryDiagonalSum = preimaryDiagonalSum + arr[index][index]
            secondaryDiagonalSum = secondaryDiagonalSum + arr[index][n-index-1]
        }
        
        return (abs(preimaryDiagonalSum - secondaryDiagonalSum))
    }
    
    func staircase(n: Int) -> Void {
        for var i in (1..<n+1){
            let spaces = String(repeating: " ", count: (n - i))
            let spaces1 = String(repeating: "#", count: i)
            print(spaces + spaces1)
        }
    }
    
    func plusMinus(arr: [Int]) -> Void {
        var a = [Int]()
        var b = [Int]()
        var c = [Int]()
        for var i in (0..<arr.count){
            if arr[i] > 0
            {
                a.append(arr[i])
            }
            else if arr[i] == 0
            {
                b.append(arr[i])
            }
            else
            {
                c.append(arr[i])
            }
        }
        
        print(a.count/arr.count)
        print(c.count/arr.count)
        print(b.count/arr.count)
        
    }
    
    func missingNumbers(arr: [Int], brr: [Int]) -> [Int] {
        var a = arr
        var b = brr
        var c = [Int]()
        
        for var i in (0..<b.count){
            if b[i] != a[i]{
                a.insert( b[i], at: i)
                if !c.contains(b[i]){
                c.append(b[i])
                }
            }
            print(c)
        }
        return c
    }

    func miniMaxSum(arr: [Int]) -> Void {
        var sum = Int()
        var vals = [Int]()
        for var i in (0..<arr.count){
            let abc = arr.reduce(0, +)
            sum = abc - arr[i]
            vals.append(sum)
        }
        print("\(vals.min() ?? 0) \(vals.max() ?? 0)")
        
    }
    
//    func pangrams(s: String) -> String {
//
//            let modifiedString = s.replacingOccurrences(of: " ", with: "")
//            let alphabet = "abcdefghijklmnopqrstuvwxyz"
//            var alphabetSet = Set(alphabet.characters)
//           let phraseSet = Set(modifiedString.lowercased().characters)
//
//            let resultSet = alphabetSet.subtract(phraseSet)
//            let sortedArray = resultArray.sort {String($0) < String($1)}
//
//
//
//            if sortedArray.count == 0 {
//                return "pangram"
//            }else{
//                return "not pangram"
//            }
//
//    }
    
    func ispalindrome(s: String) -> Bool {
        
        let reversed = String(s.reversed()).replacingOccurrences(of: " ", with: "")
        if s.lowercased() == reversed.lowercased(){
            return true
        }else{
            return false
        }
    }
    
    func gradingStudents(grades: [Int]) -> [Int] {
        var finalArr = [Int]()
        for var i in (0..<grades.count){
            if grades[i] < 38{
                finalArr.append(grades[i])
            }else{
                let a = grades[i] % 5
                if a >= 3 {
                    finalArr.append(grades[i] + (5 - a))
                } else{
                    finalArr.append(grades[i])
                }
            }
        }
        return finalArr
    }
    
    func breakingRecords(scores: [Int]) -> [Int] {
        var abc = [Int]()
        var abc1 = [Int]()
        var abc2 = [Int]()
        
        for i in scores{
            abc.append(i)
            let a = abc.max()
            let b = abc.min()
            if i > a!{
                abc1.append(i)
            }else if i < b!{
                abc2.append(i)
            }
            
        }
        return [abc1.count,abc2.count]
        
    }
    func dayOfProgrammer(year: Int) -> String {
         if year % 100 != 0{
            print("a")
        }
        if year % 400 == 0{
            return "\(256 - 244).09.\(year)"
        }else if year % 4 == 0 && year % 100 != 0{
            return "\(256 - 244).09.\(year)"
        }else{
            return "\(256 - 243).09.\(year)"
        }
    }
    func sockMerchant(n: Int, ar: [Int]) -> Int {
        var abc = [Int]()
        for var i in (0..<n)
        {
            if !abc.contains(ar[i]) {
                abc.append(ar[i])
            }
        }
        var counts: [Int: Int] = [:]
        for item in ar {
            counts[item] = (counts[item] ?? 0) + 1
        }
        print(counts)
        for var j in (0..<abc.count){
            for var k in (0..<n){
                if abc[j] == ar[k]{
                    
                }
            }
        }
        print(abc)
        return 0
    }
    
    func timeConversion(s: String) -> String {
      //  let dateAsString = s
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm:ssa"
        let date = dateFormatter.date(from: s)
        
        dateFormatter.dateFormat = "HH:mm:ss"
        let date24 = dateFormatter.string(from: date!)
        return date24
    }
    
    func bonAppetit(bill: [Int], k: Int, b: Int) -> Void {
        var sum = Int()
        var bills = bill
        if bills[k] > 0{
            bills.remove(at:k)
        }
        for i in bills{
            sum = sum + i
        }
        if sum/2 == b{
            print("Bon Appetit")
        }else{
            print((sum/2) - b)
        }
    }
    func superReducedString(s: String) -> String{
        var a = Array(s)
        for var i in (0..<a.count){
            if i != a.count{
                if a[i] == a[i + 1] {
                    a.remove(at: i)
                     if i < a.count - 1{
                        a.remove(at: i + 1)
                    }
                }
            }
        }
        var string = a.map(String.init).joined(separator: ", ")   //  "1, 2, 3, 4"
        string = string.replacingOccurrences(of: ",", with: "")
        if string == ""{
            string = "A"
        }
        return string
        
    }
    
    func birthdayCakeCandles(ar: [Int]) -> Int {
        
        var arrof = Int()
        var counts: [Int: Int] = [:]
        for item in ar {
            counts[item] = (counts[item] ?? 0) + 1
        }
        
        for (key , value) in counts{
            if value > 1{
                arrof = value
            }
        }
        return arrof
    }

}

