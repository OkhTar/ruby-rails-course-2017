require 'yaml_converter/version'
require 'my_gem/railtie' if defined?(Rails)

# YamlConverter
module YamlConverter
  require 'yaml'

  # User
  class User
    def initialize(params)
      params.each do |key, value|
        define_singleton_method(key) do
          puts(value)
          value
        end
      end
    end
  end

  puts 'Tell me your first name'
  name = gets.chomp
  puts 'And last name'
  surname = gets.chomp

  begin
    raise StandardError, "Name can't be nil" if name.empty?
  rescue StandardError
    name = 'John'
    puts 'We give you name, one way or another'
  ensure
    name = name.downcase.capitalize
  end

  begin
    raise StandardError, "Surname can't be nil" if surname.empty?
  rescue StandardError
    surname = 'Doe'
    puts 'We give you surname, one way or another'
  ensure
    surname = surname.downcase.capitalize
  end

  hash = { first_name: name, last_name: surname }
  params = hash.merge(full_name: hash.values.join(' '))
  user = User.new(params)

  user_hash = { 'user' =>
    {
      'first_name_and_last_name' => [
        'first_name' => user.first_name.to_s,
        'last_name' => user.last_name.to_s
      ],
      'full_name' => user.full_name.to_s
    } }

  File.open('user.yml', 'w') do |file|
    file.write(user_hash.to_yaml)
  end
end
