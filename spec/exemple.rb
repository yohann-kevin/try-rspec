require "spec_helper"

def all_spec(limit:, config:, expect:)
    it do
        expect(fizzbuzz(limit, config)).to eql(expect)
    end
end

RSpec.describe do
    def expect_fizzbuzz(limit:, config:, expect:)
        expect(fizzbuzz(limit, config)).to eql(expect)
    end

    def classical_fizzbuzz
        [
            ConfigTest.new(3, "fizz"),
            ConfigTest.new(5, "buzz"),
        ]
    end

    it "test with good data" do
        expect_fizzbuzz(
            limit: 15,
            config: classical_fizzbuzz,
            expect: ["fizz", "buzz", "fizz", "fizz", "buzz", "fizz", "fizzbuzz"]
        )
    end

    good_value_two = {
        :limit => 10,
        :config => classical_fizzbuzz,
        :expect => ["fizz", "buzz", "fizz", "fizz", "buzz"]
    }

    all_spec(**good_value_two)

    # test with dark data
    # test limit
    dark_limit = { :limit => "15", :config => classical_fizzbuzz, :expect => "Invalid limit" }

    all_spec(**dark_limit)

    # test config
    dark_config = { :limit => 15, :config => [], :expect => "Invalid config" }
    dark_config_two = { :limit => 15, :config => 45, :expect => "Invalid config" }
    dark_config_three = { :limit => 15, :config => [ConfigTest.new("3", "fizz"), ConfigTest.new(5, 3)], :expect => "Invalid config" }

    all_spec(**dark_config)
    all_spec(**dark_config_two)
    all_spec(**dark_config_three)
end