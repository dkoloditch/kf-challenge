class Elevator
  attr_accessor :occupied
  attr_accessor :current_floor
  attr_accessor :destination_floor
  attr_accessor :door_status
  attr_accessor :trip_count
  attr_accessor :floors_passed
  attr_accessor :maintenance_status

  UNOCCUPIED = 0
  OCCUPIED = 1
  DOORS_CLOSED = 0
  DOORS_OPEN = 1
  NOT_UNDER_MAINTENANCE = 0
  UNDER_MAINTENANCE = 1
  
  def initialize()
    @occupied = UNOCCUPIED
    @current_floor = 1
    @door_status = DOORS_CLOSED
    @trip_count = 0
    @floors_passed = 0
    @maintenance_status = NOT_UNDER_MAINTENANCE
  end

  def report_doors_open
    @door_status = DOORS_OPEN

    puts "Elevator doors are now open."
  end

  def report_doors_closed
    @door_status = DOORS_CLOSED

    puts "Elevator doors are now closed."
  end

  def report_floor_number(f)
    @current_floor = f
    puts @current_floor
  end

  def go_to_destination(request_floor_number)
    report_doors_closed
    floor_difference = (@current_floor - request_floor_number) / (@current_floor - request_floor_number)

    # iterate over floors and report floors in appropriate direction
    floor_difference.times do |f|
      report_floor_number(f)
    end

    record_floors_passed(floor_difference)
    record_trip_count
    report_doors_open

    @maintenance_status = UNDER_MAINTENANCE if time_for_maintenance?
  end

  def record_floors_passed(floors)
    @floors_passed += floors
  end

  def record_trip_count
    # unless elevator didn't actually move (was already on request floor)
    @trip_count += 1
  end

  def time_for_maintenance?
    # maintenance mode after 100 trips w/ no functionality until serviced
    maintenance_needed = @trip_count > 100

    puts "Elevator entered into maintenance." if maintenance_needed
    maintenance_needed
  end
end

class ElevatorController
  # reasoning for controller: having elevators communicate between themselves
  # adds greater complexity and potentially overhead as the number of 
  # elevators grow

  def initialize(elevators = 1, floors = 2)
    @elevators = []
    @floors = floors

    elevators.times do
      @elevators << Elevator.new
    end
  end

  def elevators
    @elevators
  end

  def request_elevator(request_floor_number)
    elevator = get_elevator(request_floor_number)
    elevator.report_doors_open

    # request can be made at any floor, to go to any other floor
    if request_floor_number < 1 || request_floor_number > @floors
      # invalid request. ask for new floor request.
    else
      elevator.go_to_destination(request_floor_number)
    end
  end

  def get_elevator(request_floor_number)
    # unoccupied, stopped elevators at request floor always have the highest priority
    e = @elevators.select {|e| e.current_floor == request_floor_number && e.occupied == Elevator::UNOCCUPIED}.first
    return e if e

    # when a request is made, the unoccupied elevator closest to it will answer the call, 
    # unless an occupied elevator is moving and will pass that floor on its way. 
    @elevators.select{|e| e.occupied == Elevator::UNOCCUPIED }.first # TODO: && closest floor

    e.current_floor = request_floor_number

    raise "Elevators not responding to requests. Maintenance needed." if !e
  end

  # def request_destination
  #   # cannot go above top floor

  #   # cannot go below ground floor (1)

  #   # set elevator occupied
  # end
end


# tests
ec = ElevatorController.new
p ec.elevators.first.door_status == Elevator::UNOCCUPIED
p ec.elevators.count == 1
p ec.elevators.first.door_status == Elevator::DOORS_CLOSED
p ec.elevators.first.trip_count == 0
p ec.elevators.first.floors_passed == 0

ec.request_elevator(1)
# moving elevator should report - need rspec to listen for appropriate calls
# respective elevator doors should be closed until arriving - need rspec to listen for appropriate calls
# closest elevator should be chosen
# elevator cannot respond to requests from floors outside limits
# elevator floor and trip counts should be accurate







