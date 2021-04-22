
ConfigTest = Struct.new(:modulo, :message)

# ConfigTest = Struct.new(:function, :message)
# ConfigTest.new(-> (i) { i % 3 == 0 },  "")

def fizzbuzz(limit, config)
  tester = test_value(limit, config)
  return tester[1] if !tester[0]
  result = Array.new
  1.upto limit do |index|
    result << testfizz(index, config)
  end
  result.delete(nil)
  result
end

def testfizz(value, config)
  fizz = if (value % config.last.modulo).zero? && (value % config.first.modulo).zero?
          "fizzbuzz"
        elsif (value % config.last.modulo).zero?
          "buzz"
        elsif (value % config.first.modulo).zero?
          "fizz"
        end
end

def test_value(limit, config)
  result = [true, ""]
  if limit.class != Integer
    result[0] = false
    result[1] = "Invalid limit"
  end
  if config.class != Array || config.empty?
    result[0] = false
    result[1] = "Invalid config"
  end
  result = test_config_value(config) if result[0]
  return result
end

def test_config_value(config)
  result = [true, ""]
  config.each do |el|
    if el.message.class != String || el.modulo.class != Integer
      result[0] = false
      result[1] = "Invalid config"
    end
  end
  result
end