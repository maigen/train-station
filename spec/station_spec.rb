require 'spec_helper'

describe Station do
  describe 'initialize' do
    it 'is initialized with a name' do
      station = Station.new('Hollywood Station')
      station.should be_an_instance_of Station
    end
    it "should give you its station name" do
      station = Station.new("Hollywood Station")
      station.name.should eq "Hollywood Station"
    end
  end
  describe '.all' do
    it 'starts with an empty array' do
      station = Station.new('Waterfront Station')
      Station.all.should eq []
    end
  end

  describe 'save' do
    it 'lets you save a new train station' do
      station = Station.new('Sunset Transit Station')
      station.save
      Station.all.should eq [station]
    end
  end
  describe '==(another_station)' do
    it 'is the same station if it has the same name' do
      station_1 = Station.new('Sunset Transit Station')
      station_2 = Station.new('Sunset Transit Station')
      station_1.should eq station_2
    end
  end

  describe 'find_line' do
    it 'lists the lines that stop at a particular station' do
    station_1 = Station.new('Sunset Transit Station', 1)
    line_1 = Line.new({'name' => "RED", 'id' => 2})
    stop_1 = Stop.new({'station_id' => 1, 'line_id' => 2})
    station_1.find_line('Sunset Transit Station').should eq 'RED'
    end
  end
end
