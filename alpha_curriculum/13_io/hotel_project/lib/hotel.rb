require_relative "room"

class Hotel

  def initialize(*args)
    @name = args[0]
    @rooms = Hash.new(0)
    args[1..-1][0].each do |key, value|
      @rooms[key] = Room.new(value)
    end
  end

  def name
    @name.split.map(&:capitalize).join(' ')
  end

  def rooms
    @rooms
  end

  def room_exists?(room_name)
    if rooms[room_name] == 0
      return false
    end
    true
  end

  def check_in(person, room_name)
    if !room_exists?(room_name)
      puts "sorry, rooms does not exist"
      return false
    end

    if @rooms[room_name].add_occupant(person)
      puts "check in successful"
      return true
    else
      puts "sorry, room is full"
      return false
    end
  end

  def has_vacancy?
    @rooms.each do |name, room|
      return true if !room.full?
    end
    false
  end

  def list_rooms
    room_fmt = ""
    @rooms.each do |name, room|
      room_fmt << name
      room_fmt << ".*"
      room_fmt << room.available_space.to_s
      room_fmt << "\n"
    end
    puts room_fmt
  end
end
