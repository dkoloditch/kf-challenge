class Elevator
  attr_accessor :occupied
  attr_accessor :current_floor
  attr_accessor :destination_floor
  attr_accessor :door_status
  attr_accessor :trip_count
  attr_accessor :floors_passed
  attr_accessor :maintenance_status

  UNOCCUPIED = "UNOCCUPIED"
  OCCUPIED = "OCCUPIED"
  DOORS_CLOSED = "CLOSED"
  DOORS_OPEN = "OPEN"
  NOT_UNDER_MAINTENANCE = "NOT_UNDER_MAINTENANCE"
  UNDER_MAINTENANCE = "UNDER_MAINTENANCE"
  MAINTENANCE_TRIP_COUNT = 100

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
    puts "Current floor: #{@current_floor}"
  end

  def go_to_destination(request_floor_number)
    report_doors_closed
    floor_difference = @current_floor == request_floor_number ? 0
                         : (@current_floor - request_floor_number) / (@current_floor - request_floor_number)

    # iterate over floors and report floors in appropriate direction
    floor_difference.times do |f|
      sleep 1
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
    maintenance_needed = @trip_count > MAINTENANCE_TRIP_COUNT

    puts "Elevator entered into maintenance." if maintenance_needed
    maintenance_needed
  end
end
