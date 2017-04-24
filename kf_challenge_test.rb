gem 'minitest', '>= 5.0.0'
require 'minitest/autorun'

require_relative "elevator_controller"
require_relative "elevator"

class ElevatorTest < Minitest::Test
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

  def test_request_from_any_floor_to_any_floor
    skip
  end

  def test_moving_elevator_reports_passing_floors
    skip
  end

  def test_elevator_reports_opening_and_closing_doors
    skip
  end

  def test_requests_cannot_exceed_floor_limits
    skip
  end

  def test_elevator_floors_passed_count
    skip
  end

  def test_elevator_trip_count
    skip
  end

  def test_elevator_enters_into_maintenance_after_x_trips
    skip
  end

  def test_elevator_not_available_during_maintenance
    skip
  end
end
