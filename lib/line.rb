
class Line
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes['name']
    @id = attributes['id']
  end

  def self.all
    results = DB.exec("SELECT * FROM line;")
    @lines = []
    results.each do |result|
      name = result['name']
      id = result['id'].to_i
      @lines << Line.new({'name' => name, 'id' => id})
    end
    @lines
  end

  def save
    results = DB.exec("INSERT INTO line (name) VALUES ('#{@name}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_line)
    self.name == another_line.name
  end

  def find_stations(line_id)
    station_names_array = []
    station_ids = DB.exec("SELECT station.* FROM line JOIN stops ON (line.id = stops.line_id) JOIN station ON (stops.station_id = station.id) WHERE line.id = 3;")
    station_ids.each do |result|
      name = result["name"]
      station_names_array << name
    end
    station_names_array
  end

end
