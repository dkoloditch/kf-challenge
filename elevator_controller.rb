require_relative "elevator"

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

  def get_unoccupied_elevators
    elevators.select{|e| e.occupied == Elevator::UNOCCUPIED}
  end

  def request_elevator(request_floor_number)
    elevator = get_elevator(request_floor_number)

    # request can be made at any floor, to go to any other floor
    if request_floor_number < 1 || request_floor_number > @floors
      # invalid request. ask for new floor request.
    else
      elevator.go_to_destination(request_floor_number)
    end
  end

  def get_elevator(request_floor_number)
    # unoccupied, stopped elevators at request floor always have the highest
    # priority
    elevator = @elevators.select {|e| e.current_floor == request_floor_number && e.occupied == Elevator::UNOCCUPIED}.first
    return elevator if elevator

    # when a request is made, the unoccupied elevator closest to it will answer
    # the call, unless an occupied elevator is moving and will pass that floor
    # on its way.

    index_of_closest_elevator = 0
    unoccupied_elevators = get_unoccupied_elevators

    unoccupied_elevators.each_with_index do |e, i|
      current_floor = e.current_floor
      current_floor_difference = (request_floor_number - current_floor).abs
      previous_floor_difference = (request_floor_number - @elevators[index_of_closest_elevator].current_floor).abs

      if current_floor_difference < previous_floor_difference
        index_of_closest_elevator = i
      end
    end

    elevator = unoccupied_elevators[index_of_closest_elevator]

    elevator.go_to_destination(request_floor_number)
    elevator.report_doors_open

    if elevator
      return elevator
    else
      raise "Elevators not responding to requests. Maintenance needed."
    end
  end
end
