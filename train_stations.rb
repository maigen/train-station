require 'pg'
require './lib/line'
require './lib/station'
require './lib/stop'
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
  line_name = gets.chomp
  new_line = Line.new(line_name)
  new_line.save
  puts "\n#{line_name} has been added as a new line.\n\n\n"
  conductor_menu
end

def connect_menu
  puts "This is a list of current lines. Please enter the number of the line you want to connect a station to.\n"
  Line.all.each_with_index do |line, index|
    puts "#{index + 1}" + ". " + "#{line.name}\n"
  end
  line = gets.chomp.to_i
  puts "\n\n"
  puts "This is a list of current stations.  Please enter the number of the station you want to connect the line to.\n"
  Station.all.each_with_index do |station, index|
    puts "#{index + 1}. #{station.name}\n"
  end
  station = gets.chomp.to_i
  new_stop = Stop.new({'station_id' => station, 'line_id' => line})
  new_stop.save
  puts "You have added #{Station.all[station-1].name} to the #{Line.all[line-1].name} train line.\n\n"
  gets.chomp
  system "clear"
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


main_menu


