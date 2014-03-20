require 'pry'
class Station
  attr_reader :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def self.all
    results = DB.exec("SELECT * FROM station;")
    stations = []
    results.each do |result|
      name = result['name']
      id = result['id']
      stations << Station.new(name, id)
    end
    stations
  end

  def save
    results = DB.exec("INSERT INTO station (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_station)
    self.name == another_station.name
  end

  def find_line(station_id)
    line_names_array = []
    line_ids = DB.exec("SELECT line_id FROM stops WHERE station_id = #{station_id};")
    line_ids.each do |result|
      id = result["line_id"]
      line_names = DB.exec("SELECT name FROM line WHERE id = #{id};")
      line_names_array << line_names.first['name']
    end
    line_names_array

  end

end

