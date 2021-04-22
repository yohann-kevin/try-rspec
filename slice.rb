#!/usr/bin/env ruby

require "bigdecimal"
require "bigdecimal/util"

AMOUNT_FMT = /\A\d+(\.\d{1,2})?\z/
TAX_RATE_FMT = AMOUNT_FMT
DISCOUNT_FMT = AMOUNT_FMT

STATE_TAXES = {
  "CA" => "8.25".to_d,
  # Add more here...
}

class Amount
  def initialize(value)
    @value = value.to_d
  end

  def apply_taxes(percentage)
    ratio = percentage.to_d / 100 + 1
    Amount.new((@value * ratio).floor(2))
  end

  def apply_discount(percentage)
    ratio = percentage.to_d / -100 + 1
    Amount.new((@value * ratio).floor(2))
  end

  def to_s
    @value.to_s("F")
  end
end

def prompt(message)
  if ARGV.empty?
    puts message
    gets.chomp
  else
    ARGV.shift
  end
end

def prompt_amount(message)
  value = prompt(message)
  raise "Invalid amount" unless value =~ AMOUNT_FMT
  Amount.new(value)
end

def prompt_tax_rate(message)
  value = prompt(message)
  raise "Invalid tax rate format" unless value =~ TAX_RATE_FMT
  value.to_d
end

def prompt_tax_rate_from_state(message)
  value = prompt(message)
  STATE_TAXES.fetch(value)
end

def prompt_discount(message)
  value = prompt(message)
  raise "Invalid discount format" unless value =~ DISCOUNT_FMT
  value.to_d
end


amount = prompt_amount("Entrez le prix:")
tax_rate = prompt_tax_rate_from_state("Entrez l'état dans lequel la vente est réalisée:")
discount = prompt_discount("Entrez la remise à réaliser:")

amount = amount.apply_taxes(tax_rate).apply_discount(discount)

puts "Résultat: #{amount}"
