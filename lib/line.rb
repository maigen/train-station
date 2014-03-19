
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

end
