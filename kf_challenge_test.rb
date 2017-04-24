gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'

require_relative "elevator_controller"
require_relative "elevator"

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

  def test_get_all_elevators
    ec = ElevatorController.new(3, 10)
    assert ec.get_all_elevators.count, 3
  end

  def test_gets_only_unoccupied_elevators
    ec = ElevatorController.new(3, 10)
    elevators = ec.get_all_elevators
    elevators[0].occupied = Elevator::OCCUPIED
    elevators[1].occupied = Elevator::OCCUPIED
    unoccupied_elevators = ec.get_unoccupied_elevators
    assert_equal 1, unoccupied_elevators.count
    assert_equal elevators[2], unoccupied_elevators.first
  end

  def test_get_elevator_returns_passing_occupied_elevator_first
    ec = ElevatorController.new(4, 10)
    elevators = ec.get_all_elevators

    # unoccupied elevator is closest
    request_floor_number = 5
    elevators[0].occupied = Elevator::OCCUPIED
    elevators[0].current_floor = 1
    elevators[0].door_status = Elevator::DOORS_CLOSED
    elevators[0].destination_floor = 10
    elevators[1].occupied = Elevator::OCCUPIED
    elevators[0].current_floor = 2
    elevators[2].occupied = Elevator::OCCUPIED
    elevators[2].current_floor = 10
    elevators[3].current_floor = 6

    assert_equal elevators[0], ec.get_elevator(5)
  end

  def test_get_elevator_returns_closest_unoccupied_elevator
    ec = ElevatorController.new(4, 10)
    elevators = ec.get_all_elevators

    # unoccupied elevator is farthest away
    request_floor_number = 3
    elevators[0].occupied = Elevator::OCCUPIED
    elevators[0].current_floor = 2
    elevators[1].occupied = Elevator::OCCUPIED
    elevators[0].current_floor = 3
    elevators[2].occupied = Elevator::OCCUPIED
    elevators[2].current_floor = 4
    elevators[3].current_floor = 1

    assert_equal elevators[3], ec.get_elevator(3)

    # unoccupied elevator is closest
    request_floor_number = 5
    elevators[0].occupied = Elevator::OCCUPIED
    elevators[0].current_floor = 1
    elevators[1].occupied = Elevator::OCCUPIED
    elevators[0].current_floor = 2
    elevators[2].occupied = Elevator::OCCUPIED
    elevators[2].current_floor = 10
    elevators[3].current_floor = 6

    assert_equal elevators[3], ec.get_elevator(5)
  end
end
