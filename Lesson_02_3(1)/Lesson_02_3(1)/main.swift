//
//  main.swift
//  Lesson_02_3(1)
//
//  Created by user on 21.10.16.
//  Copyright © 2016 user. All rights reserved.
//

import Foundation

/*Написати аналізатор виразу і його обчислення.
 Вираз містить такі знаки +, -, *, /, (), sqr(), sqrt().
 Наприклад: 2 + (3 * sqr(2) - sqrt(4))/5
 Рівні складності:
 1. Вираз включає операції: +, -, *, /
 2. Вираз включає операції: +, -, *, /, ()
 3. Вираз включає операції: +, -, *, /, (), sqr(), sqrt()
 */

var ourString = "5+25* 3/3 +5*2 -1 0 +10 -5*2-10"
var tempString = ""
var result = 0
var arrayOfSymbols = [String]()         //таблиця знаків для всіх дій
var arrayOfNumbers = [Int]()            //таблиця чисел для всіх дій
var newArrayOfSymbols = [String]()      //таблиця знаків для дій + і -
var newArrayOfNumbers = [Int]()         //таблиця чисел для дій + і -
var i = 0

//убираю пропуски в рядку
ourString = ourString.replacingOccurrences(of: " ", with: "")


//йдемо по довжині всього виразу розбиваємо на літери
for i in 0..<ourString.characters.count {
    let charSymbol = ourString.index(ourString.startIndex, offsetBy: i)
    var singleCharacter = String(ourString[charSymbol])
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
result = newArrayOfNumbers[0]
for i in 1..<newArrayOfNumbers.count {
    if newArrayOfSymbols[i-1] == "+" {
        result += newArrayOfNumbers[i]
    }
    if newArrayOfSymbols[i-1] == "-" {
        result -= newArrayOfNumbers[i]
    }
}
print(result)

