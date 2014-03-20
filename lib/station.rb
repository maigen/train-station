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


    line_ids = DB.exec("Select line_id FROM stops WHERE station_id = #{station_id};")

    #something around here is broken
    line_results = DB.exec("Select name FROM line WHERE id = #{results.id};")
    line_results
  end

end

