require 'pg'
require './lib/line'
require './lib/station'
require './lib/stop'
require 'pry'

DB = PG.connect(:dbname => 'trains')

system "clear"

def main_menu
  puts "Welcome to Amityville Trains. Would you like to access the database as a passenger or conductor?\n"
  puts "For passenger, enter 'p', for conductor, enter 'c'.\n"
  puts "To exit the system, enter 'x'.\n\n"
  entry = gets.chomp
  case entry
  when 'p'
  system "clear"
  passenger_menu
  when 'c'
  system "clear"
  conductor_menu
  when 'x'
  system "clear"
  puts "Thank you. Goodbye.\n\n\n"
  else
  system "clear"
  main_menu
  end
end

def conductor_menu
  puts "What would you like to do?  Enter"
  puts "\t'S' to add a train station."
  puts "\t'L' to add a train line."
  puts "\t'M' to return to the main menu."
  puts "\t'C' to connect a station to a line or a line to a station."
  puts "To exit the system, enter 'x'.\n\n"
  c_input = gets.chomp.upcase
  case c_input
  when 'S'
    system "clear"
    add_station
  when 'L'
    system "clear"
    add_line
  when 'X'
    system "clear"
    puts "Thank you. Goodbye.\n\n\n"
  when 'C'
    system "clear"
    connect_menu
  else
    system "clear"
    main_menu
  end
end

def add_station
  puts "Enter the name of the new station\n\n"
  station_name = gets.chomp.upcase
  new_station = Station.new(station_name)
  new_station.save
  puts "\n#{station_name} has been added as a new station.\n\n\n"
  conductor_menu
end

def add_line
  puts "Enter the name of the new line\n\n"
  line_name = gets.chomp.upcase
  new_line = Line.new({'name' =>line_name})
  new_line.save
  puts "\n#{line_name} has been added as a new line.\n\n\n"
  conductor_menu
end

def connect_menu
  puts "What station would you like to connect?\n\n\n"
  Station.all.each do |station|
    puts "\t#{station.name}\n"
  end
  user_station_name = gets.chomp.upcase
  this_station = Station.all.detect {|station| station.name == user_station_name}
  puts "\n\nWhat line would you like to stop at #{user_station_name}?\n\n"
  Line.all.each do |line|
    puts "\t#{line.name}\n"
  end
  user_line_name = gets.chomp.upcase
  this_line = Line.all.detect {|line| line.name == user_line_name}
  new_connection = Stop.new({'station_id' => this_station.id, 'line_id' => this_line.id})
  new_connection.save
  puts "\nYou have successfully connected the #{this_line.name} to the #{this_station.name}.\n\n"
  conductor_menu
end


def passenger_menu
  puts "What would you like to do?  Enter"
  puts "\t'S' to view a station and the lines that stop at that station."
  puts "\t'L' to view a train line and the stations that the line stops at."
  puts "\t'M' to return to the main menu."
  puts "To exit the system, enter 'x'.\n\n"
  p_input = gets.chomp.upcase
  case p_input
  when 'S'
    system "clear"
    view_station
  when 'L'
    system "clear"
    view_line
  when 'X'
    system "clear"
    puts "Thank you. Goodbye.\n\n\n"
  else
    system "clear"
    main_menu
  end
end

def view_station
  puts "To view the lines servicing a particular station, please enter the station name.\n\n"
    Station.all.each do |station|
      puts "\t#{station.name}\n"
    end
  request = gets.chomp.upcase
  chosen_station = Station.all.detect { |station| station.name == request }
  station_id = chosen_station.id.to_i
  puts "\n\nHere are the train lines that come to this station: "
  puts "\n\n"
  puts chosen_station.find_line(station_id)
  puts "\n\n"
  gets.chomp
  system "clear"
  passenger_menu
end

def view_line
  puts "Which line would you like to view stops on?\n\n"
    Line.all.each do |line|
      puts "\t#{line.name}\n"
    end
  request = gets.chomp.upcase
  chosen_line = Line.all.detect { |line| line.name == request }
  line_id = chosen_line.id.to_i
  puts "\n\n Here are the stations visited by this train line:\n\n"
  puts chosen_line.find_stations(line_id)
  puts "\n\n"
  gets.chomp
  system "clear"
  passenger_menu
end


main_menu


