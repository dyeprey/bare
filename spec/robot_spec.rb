require 'spec_helper'
require_relative '../robot'

RSpec.describe 'Robot' do
  before(:each) do
    $current_x_position = nil
    $current_y_position = nil
    $current_orientation = nil
  end

  context "Moving" do
    it 'it moves Y axis' do
      place("0,0,N")
      move
      expect { report }.to output(/0, 1, N/).to_stdout
    end

    it 'it moves X axis' do
      place("0,0,E")
      move
      expect { report }.to output(/1, 0, E/).to_stdout
    end

    it 'does not move out of bounds W' do
      place("0,0,W")
      move
      expect { report }.to output(/0, 0, W/).to_stdout
    end

    it 'does not move out of bounds S' do
      place("0,0,S")
      move
      expect { report }.to output(/0, 0, S/).to_stdout
    end

    it 'does not move out of bounds N' do
      place("0,5,N")
      move
      expect { report }.to output(/0, 5, N/).to_stdout
    end

    it 'does not move out of bounds E' do
      place("5,0,E")
      move
      expect { report }.to output(/5, 0, E/).to_stdout
    end

    it 'can be placed again' do
      place("0,0,N")
      move
      place("0,0,E")
      expect { report }.to output(/0, 0, E/).to_stdout
    end
  end

  context "Turning" do
    it 'turns left' do
      place("0,0,N")
      turn_left
      expect { report }.to output(/0, 0, W/).to_stdout
    end

    it 'turns right' do
      place("0,0,N")
      turn_right
      expect { report }.to output(/0, 0, E/).to_stdout
    end

    it 'turns back to first orientation' do
      place("0,0,W")
      turn_right
      expect { report }.to output(/0, 0, N/).to_stdout
    end

    it 'can multiple turns' do
      place("0,0,N")
      turn_left
      turn_left
      turn_right
      turn_right
      expect { report }.to output(/0, 0, N/).to_stdout
    end
  end

  context 'errors' do
    it 'handles invalid PLACE command' do
      expect { place("0,0,X") }.to output(/Allowed values for orientations are N, E, S, W/).to_stdout
    end

    it 'handles robot not place yet' do
      expect { move }.to output(/Robot not placed, please place the robot by using the PLACE command/).to_stdout
    end

    it 'handles missing PLACE command' do
      expect { move }.to output(/Robot not placed, please place the robot by using the PLACE command/).to_stdout
    end

    it 'will not turn if robot was not placed' do
      expect { turn_left }.to output(/Robot not placed, please place the robot by using the PLACE command/).to_stdout
    end
    
    it 'will not turn right if robot was not placed' do
      expect { turn_right }.to output(/Robot not placed, please place the robot by using the PLACE command/).to_stdout
    end
  end
end