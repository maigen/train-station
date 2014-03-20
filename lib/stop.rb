
class Stop
  attr_reader :id, :line_id, :station_id

  def initialize(attributes)
    @id = attributes['id']
    @station_id = attributes['station_id']
    @line_id = attributes['line_id']
  end

  def self.all
    results = DB.exec("SELECT * FROM stops;")
    stops = []
    results.each do |result|
      id = result['id'].to_i
      station_id = result['station_id'].to_i
      line_id = result['line_id'].to_i
      stops << Stop.new({'id' => id, 'station_id' => station_id, 'line_id' => line_id})
    end
    stops
  end

  def save
    results = DB.exec("INSERT INTO stops (station_id, line_id) VALUES ('#{@station_id}', '#{@line_id}') RETURNING id;")
    @id = results.first['id'].to_i
  end

  def ==(another_stop)
    self.station_id == another_stop.station_id && self.line_id == another_stop.line_id
  end

end

