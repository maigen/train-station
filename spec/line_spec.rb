require 'spec_helper'

describe Line do
  describe 'initialize' do
    it 'is initialized with a hash of attributes' do
      line = Line.new({'name' => 'Red Line'})
      line.should be_an_instance_of Line
    end
    it "should give you its line name" do
      line = Line.new({'name' => 'Red Line'})
      line.name.should eq "Red Line"
    end
  end
  describe '.all' do
    it 'starts with an empty array' do
      line = Line.new({'name' => 'Red Line'})
      Line.all.should eq []
    end
  end

  describe 'save' do
    it 'lets you save a new train line' do
      line = Line.new({'name' => 'Blue Line'})
      line.save
      Line.all.should eq [line]
    end
  end
  describe '==(another_line)' do
    it 'is the same line if it has the same name' do
      line_1 = Line.new({'name' => 'Blue Line'})
      line_2 = Line.new({'name' => 'Blue Line'})
      line_1.should eq line_2
    end
  end

end
