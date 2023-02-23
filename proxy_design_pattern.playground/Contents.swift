import UIKit

protocol BankAccount {
    func deposit(amount: Double)
    func withdraw(amount: Double)
    var balance: Double { get }
}

class BankAccountImpl: BankAccount {
    private var accountBalance: Double = 0
    
    func deposit(amount: Double) {
        accountBalance += amount
        print("Deposited \(amount), account balance now \(accountBalance)")
    }
    
    func withdraw(amount: Double) {
        if accountBalance >= amount {
            accountBalance -= amount
            print("Withdrew \(amount), account balance now \(accountBalance)")
        } else {
            print("Insufficient funds")
        }
    }
    
    var balance: Double {
        return accountBalance
    }
}

class BankAccountProxy: BankAccount {
    private var realBankAccount: BankAccountImpl
    
    init() {
        realBankAccount = BankAccountImpl()
    }
    
    func deposit(amount: Double) {
        realBankAccount.deposit(amount: amount)
    }
    
    func withdraw(amount: Double) {
        realBankAccount.withdraw(amount: amount)
    }
    
    var balance: Double {
        return realBankAccount.balance
    }
}

let bankAccount: BankAccount = BankAccountProxy()
bankAccount.deposit(amount: 1000.0)
bankAccount.withdraw(amount: 500.0)
print("Account balance: \(bankAccount.balance)")
