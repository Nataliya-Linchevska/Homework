//
//  main.swift
//  Lesson02-3-2lvl
//
//  Created by user on 24.10.16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation

var myString = "(100-40+((2+3)*3-5)+(20-10)+100-40)"    //=100
var tempStr = ""
var arrayOfStr = [String]()

//убираю пропуски в рядку
myString = myString.replacingOccurrences(of: " ", with: "")

// Обрахунок дій з попереднього рівня кидаю в функцію для обчислення + - * /
func calculateResult(ourString: String) -> Int {
    var tempString = ""
    var result = 0
    var arrayOfSymbols = [String]()         //таблиця знаків для всіх дій
    var arrayOfNumbers = [Int]()            //таблиця чисел для всіх дій
    var newArrayOfSymbols = [String]()      //таблиця знаків для дій + і -
    var newArrayOfNumbers = [Int]()         //таблиця чисел для дій + і -
    var i = 0
    //йдемо по довжині всього виразу розбиваємо на літери
    for i in 0..<ourString.characters.count {
        let charSymbol = ourString.index(ourString.startIndex, offsetBy: i)
        let singleCharacter = String(ourString[charSymbol])
        //Шукаємо необхідні числа та дії
        switch singleCharacter {
        case "0", "1", "2", "3", "4", "5", "6", "7", "8", "9":
            tempString += singleCharacter
        case "+", "-", "*", "/" :
            arrayOfNumbers += [Int(tempString)!]
            arrayOfSymbols += [singleCharacter]
            tempString = ""
        default:
            print("Ups problem, look at your code!")
        }
    }
    arrayOfNumbers += [Int(tempString)!]  //щоб додало останнє число
    //проганяємо по циклі знаків
    while i < arrayOfSymbols.count {
        switch arrayOfSymbols[i] {
        case "+" :
            newArrayOfNumbers += [arrayOfNumbers[i]]
        case "-" :
            newArrayOfNumbers += [arrayOfNumbers[i]]
        case "*" , "/":
            // зациклюємо множ та діл поки все не перахує - не вийде (щоб рахувало коли підряд багато разів дія першого пріорітету)
            var newI = i
            while arrayOfSymbols.count > newI && ((arrayOfSymbols[newI] == "*") || (arrayOfSymbols[newI] == "/")) {
                if arrayOfSymbols[newI] == "*" {
                    result = arrayOfNumbers[newI]*arrayOfNumbers[newI+1]
                    arrayOfNumbers[newI+1] = result
                }
                if arrayOfSymbols[newI] == "/" {
                    result = arrayOfNumbers[newI]/arrayOfNumbers[newI+1]
                    arrayOfNumbers[newI+1] = result
                }
                newI += 1
            }
            i = newI
            newArrayOfNumbers += [result]
        default:
            print("Ups problem, look at your code!")
        }
        i += 1
    }
    // щоб додати останнє число в масив при діях + та -
    if arrayOfSymbols.last == "+" || arrayOfSymbols.last == "-" {
        newArrayOfNumbers += [arrayOfNumbers[i]]
    }
    //додаємо до таблиці символів лише + та -
    for symbol in arrayOfSymbols {
        if symbol == "+" || symbol == "-" {
            newArrayOfSymbols += [symbol]
        }
    }
    //присвоюємо результату перше число та починаючи з другого проганяємо по + та -
    if newArrayOfNumbers.count == 0 {
        result = arrayOfNumbers[0]
    } else{
        result = newArrayOfNumbers[0]
        for i in 1..<newArrayOfNumbers.count {
            if newArrayOfSymbols[i-1] == "+" {
                result += newArrayOfNumbers[i]
            }
            if newArrayOfSymbols[i-1] == "-" {
                result -= newArrayOfNumbers[i]
            }
        }
    }
     //   print(result)
        return result
}
//--------------- кінець функції ---------------

// Обчислюю дужки

func calculateBrecket(myIndex: Int) {
    //витаскую і-тий елемент з рядка
    let elementIndex = myString.characters.index(myString.startIndex, offsetBy: myIndex)
    let elementStr = String(myString[elementIndex])
    // шукаю ) і добавляю до тимчасового стрінга вираз, якщо він є
    
    if elementStr == ")" {
        arrayOfStr += [tempStr]
        if(!tempStr.isEmpty){
            tempStr = String(calculateResult(ourString: tempStr))
        }
    }
    if elementStr == "("  {
        // обнуляю тимчасовий стрінг якщо знайшли (
        //arrayOfStr += [tempStr]
        if(!tempStr.isEmpty) {
            let sygn = tempStr[tempStr.index(before: tempStr.endIndex)]
            tempStr.remove(at: tempStr.index(before: tempStr.endIndex))
            tempStr = String(calculateResult(ourString: tempStr))
            tempStr += String(sygn)
            print(tempStr)
        }
        arrayOfStr += [tempStr]
        tempStr = ""
    } else {
        //убираю лишні дужки
        tempStr += elementStr != ")" ? elementStr : ""
        
        //tempStr = String(calculateResult(ourString: tempStr))
    }
    //запускаю функцію для наступного елементу
    if (myIndex+1) < myString.characters.count {
        calculateBrecket(myIndex: myIndex+1)
    }
}

calculateBrecket(myIndex: 0)
print(arrayOfStr)






