class Elevator
  
  def initialize(floors = 1)
  end

  def report_floor_number
  end

  def report_open_doors
  end

  def report_closed_doors
  end

  # cannot go above top floor

  # cannot go below ground floor (1)

  # request can be made at any floor, to go to any other floor

  # when a request is made, the unoccupied elevator closest to it will answer the call, 
  # unless an occupied elevator is moving and will pass that floor on its way. 
  # EXCEPTION: if an unoccupied elevator is already stopped at that floor, 
  # then it will always have the highest priority answering that call.

  # log trip count

  # log floors passed

  # maintenance mode after 100 trips w/ no functionality until serviced
end

class Supervisor

  def initialize(elevators = 1)
    @elevators = []
  end
end