#!/usr/bin/env ruby
# Lean Architecture example in Ruby - with ContextAccessor

# This example keeps interaction state in a "current context", represented
# by a ContextAccessor module. This can be mixed in to any class that needs 
# access to the current context. It is implemented as a thread-local variable.

# -----------------------------------
module ContextAccessor
  def context
    Thread.current[:context]
  end
  
  def context=(ctx)
    Thread.current[:context] = ctx
  end
  
  # Pass a block to this to have it executed with this context set
  def in_context
    old_context = self.context
    self.context = self
    yield
    self.context = old_context
  end
end

# -----------------------------------
# Model class with no external dependenices. Includes a simple find method
# to create and store instances given an id - for illustration purposes only.
class Account
  attr_reader :account_id, :balance
  
  def initialize(account_id)
    @account_id = account_id
    @balance = 0
  end
  
  def withdraw(amount)
    raise "Insufficient funds" if amount < 0
    @balance -= amount
  end
  
  def deposit(amount)
    @balance += amount
  end

  def update_log(msg, date, amount)
    puts "Account: #{inspect}, #{msg}, #{date.to_s}, #{amount}"
  end
  
  def self.find(account_id)
    @@store ||= Hash.new
    return @@store[account_id] if @@store.has_key? account_id
    
    if :savings == account_id
      account = SavingsAccount.new(account_id)
      account.deposit(100000)
    elsif :checking == account_id
      account = CheckingAccount.new(account_id)
    else
      account = Account.new(account_id)
    end
    @@store[account_id] = account
    account
  end  
end

# -----------------------------------
class Creditor
  attr_accessor :amount_owed, :account
  
  def self.find(name)
    @@store ||= Hash.new
    return @@store[name] if @@store.has_key? name
    
    if :baker == name
      creditor = Creditor.new
      creditor.amount_owed = 50
      creditor.account = Account.find(:baker_account)
    elsif :butcher == name
      creditor = Creditor.new
      creditor.amount_owed = 90
      creditor.account = Account.find(:butcher_account)
    end
    creditor
  end
      
end

# -----------------------------------
module MoneySource
  include ContextAccessor
  
  def transfer_out
    raise "Insufficient funds" if balance < context.amount  
    withdraw context.amount
    context.destination_account.deposit context.amount
    update_log "Transfer Out", Time.now, context.amount
    context.destination_account.update_log "Transfer In", Time.now, context.amount
  end
  
  def pay_bills
    creditors = context.creditors.dup
    creditors.each do |creditor|
      TransferMoneyContext.execute(creditor.amount_owed, account_id, creditor.account.account_id)
    end
  end
end

# -----------------------------------
# Use case: Transfer Money
class TransferMoneyContext
  attr_reader :source_account, :destination_account, :amount
  include ContextAccessor

  def self.execute(amt, source_account_id, destination_account_id)
    TransferMoneyContext.new(amt, source_account_id, destination_account_id).execute
  end
  
  def initialize(amt, source_account_id, destination_account_id)
    @source_account = Account.find(source_account_id)
    @source_account.extend MoneySource

    @destination_account = Account.find(destination_account_id)
    @amount = amt
  end

  def execute
    in_context do
      source_account.transfer_out
    end
  end

end

# -----------------------------------
class PayBillsContext
  attr_reader :source_account, :creditors
  include ContextAccessor
  
  def self.execute(source_account_id, creditor_names)
    PayBillsContext.new(source_account_id, creditor_names).execute
  end
  
  def initialize(source_account_id, creditor_names)
    @source_account = Account.find(source_account_id)
    @creditors = creditor_names.map do |name|
      Creditor.find(name)
    end
  end

  def execute
    in_context do
      source_account.pay_bills
    end
  end  
  
end

# -----------------------------------
class SavingsAccount < Account
end

class CheckingAccount < Account
end

TransferMoneyContext.execute(300, :savings, :checking)
TransferMoneyContext.execute(100, :checking, :savings)

puts "Savings: #{Account.find(:savings).balance}, Checking: #{Account.find(:checking).balance}"

# Now pay some bills
PayBillsContext.execute(:checking, [ :baker, :butcher])

puts "After paying bills, checking has: #{Account.find(:checking).balance}"
puts "Baker and butcher have #{Account.find(:baker_account).balance}, #{Account.find(:butcher_account).balance}"

