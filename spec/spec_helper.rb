require 'line'
require 'pg'
require 'station'
require 'stop'
require 'rspec'
require 'pry'

DB = PG.connect(:dbname => 'trains_test')
RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM line *;")
    DB.exec("DELETE FROM station *;")
    DB.exec("DELETE FROM stops *;")
  end
end
