gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'

require_relative "elevator_controller"

class ElevatorTest < Minitest::Test
  # @ec = ElevatorController.new
  # p ec.elevators.first.door_status == Elevator::UNOCCUPIED
  # p ec.elevators.count == 1
  # p ec.elevators.first.door_status == Elevator::DOORS_CLOSED
  # p ec.elevators.first.trip_count == 0
  # p ec.elevators.first.floors_passed == 0

  # ec.request_elevator(2)
  # moving elevator should report - need rspec to listen for appropriate calls
  # respective elevator doors should be closed until arriving - need rspec to listen for appropriate calls
  # closest elevator should be chosen
  # elevator cannot respond to requests from floors outside limits
  # elevator floor and trip counts should be accurate

  def test_basic_test
    ec = ElevatorController.new
    assert_equal ec.class, ElevatorController
  end

  def test_elevator_request
    ec = ElevatorController.new
    assert ec.request_elevator(2), nil
  end
end
