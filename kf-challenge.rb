class Elevator
  attr_accessor :occupied
  attr_accessor :current_floor
  attr_accessor :destination_floor
  attr_accessor :door_status
  attr_accessor :trip_count
  attr_accessor :floors_passed

  UNOCCUPIED = 0
  OCCUPIED = 1
  DOORS_CLOSED = 0
  DOORS_OPEN = 1
  
  def initialize(floors = 1)
    @occupied = UNOCCUPIED
    @current_floor = 1
    @door_status = DOORS_CLOSED
    @trip_count = 0
    @floors_passed = 0
  end

  def report_floor_number
    puts @current_floor
  end

  def report_doors_open
  end

  def report_doors_closed
  end

  def record_trip_count
    # up and down
  end

  def record_floors_passed
    # any change in movement
  end

  def time_for_maintenance?
    # maintenance mode after 100 trips w/ no functionality until serviced
    @trip_count > 100
  end
end

class ElevatorController
  # reasoning for controller: having elevators communicate between themselves
  # adds greater complexity and potentially overhead as the number of 
  # elevators grow

  def initialize(elevators = 1)
    @elevators = []

    elevators.times do
      @elevators << Elevator.new
    end
  end

  def elevators
    @elevators
  end

  def request_elevator
    elevator = get_elevator

    # request can be made at any floor, to go to any other floor

    # implicit: requests FOR elevators (not floors) can be made from within 
    # the elevator or from specific floors
  end

  def get_elevator
    # is an unoccupied elevator is already stopped at that floor?
    # then it will always have the highest priority answering that call.

    # when a request is made, the unoccupied elevator closest to it will answer the call, 
    # unless an occupied elevator is moving and will pass that floor on its way. 
  end

  def request_destination
    # cannot go above top floor

    # cannot go below ground floor (1)

    # set elevator occupied
  end
end


# tests
ec = ElevatorController.new
p ec.elevators.first.door_status == Elevator::UNOCCUPIED
p ec.elevators.count == 1
p ec.elevators.first.door_status == Elevator::DOORS_CLOSED
p ec.elevators.first.trip_count == 0
p ec.elevators.first.floors_passed == 0







