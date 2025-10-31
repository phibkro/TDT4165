
class Account(val code : String, val balance: Double) {
    def withdraw(amount: Double) : Either[Error, Account] = {
        if (amount < 0) then
            Left(Error("Withdraw amount cannot be negative"))
        else if balance < amount then
            Left(Error("Withdraw amount larger than account balance"))
        else 
            Right(Account(code, balance - amount))
    }
    def deposit (amount: Double) : Either[Error, Account] = {
        if (amount <= 0) then
            Left(Error("Deposit amount too low"))
        else
            Right(Account(code, balance + amount))
    }
}
