require 'spec_helper'

describe Stop do
  describe 'initialize' do
    it 'is initialized with a hash of attributes' do
      stop = Stop.new({'station_id' => 1, 'line_id' => 2})
      stop.should be_an_instance_of Stop
    end
    it "should give you its line and station id numbers" do
      stop = Stop.new({'station_id' => 1, 'line_id' => 2})
      stop.line_id.should eq 2
      stop.station_id.should eq 1
    end
  end
  describe '.all' do
    it 'starts with an empty array' do
      stop = Stop.new({'station_id' => 1, 'line_id' => 2})
      Stop.all.should eq []
    end
  end

  describe 'save' do
    it 'lets you save a stop' do
      stop = Stop.new({'station_id' => 1, 'line_id' => 2})
      stop.save
      Stop.all.should eq [stop]
    end
  end
  describe '==(another_stop)' do
    it 'is the same line if it has the same name' do
      stop1 = Stop.new({'station_id' => 1, 'line_id' => 2})
      stop2 = Stop.new({'station_id' => 1, 'line_id' => 2})
      stop1.should eq stop2
    end
  end
end
