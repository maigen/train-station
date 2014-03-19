
class Station
  attr_reader :name, :id

  def initialize(name)
    @name = name
  end

  def self.all
    results = DB.exec("SELECT * FROM station;")
    stations = []
    results.each do |result|
      name = result['name']
      stations << Station.new(name)
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

end
