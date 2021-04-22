require "spec_helper"

def all_spec(limit, config, expect)
    it "return #{expect}" do
        expect(fizzbuzz(limit, config)).to eql(expect)
    end
end

RSpec.describe do
    # test with good data
    good_value = {
        :limit => 15,
        :config => [
            ConfigTest.new(3, "fizz"),
            ConfigTest.new(5, "buzz")
        ],
        :expect => ["fizz", "buzz", "fizz", "fizz", "buzz", "fizz", "fizzbuzz"]
    }

    good_value_two = {
        :limit => 10,
        :config => [
            ConfigTest.new(3, "fizz"),
            ConfigTest.new(5, "buzz")
        ],
        :expect => ["fizz", "buzz", "fizz", "fizz", "buzz"]
    }

    all_spec(good_value[:limit], good_value[:config], good_value[:expect])
    all_spec(good_value_two[:limit], good_value_two[:config], good_value_two[:expect])

    # test with dark data
    # test limit
    dark_limit = { :limit => "15", :config => [ConfigTest.new(3, "fizz"), ConfigTest.new(5, "buzz")], :expect => "Invalid limit" }

    all_spec(dark_limit[:limit], dark_limit[:config], dark_limit[:expect])

    # test config
    dark_config = { :limit => 15, :config => [], :expect => "Invalid config" }
    dark_config_two = { :limit => 15, :config => 45, :expect => "Invalid config" }
    dark_config_three = { :limit => 15, :config => [ConfigTest.new("3", "fizz"), ConfigTest.new(5, 3)], :expect => "Invalid config" }

    all_spec(dark_config[:limit], dark_config[:config], dark_config[:expect])
    all_spec(dark_config_two[:limit], dark_config_two[:config], dark_config_two[:expect])
    all_spec(dark_config_three[:limit], dark_config_three[:config], dark_config_three[:expect])
end