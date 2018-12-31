class Employee
  attr_accessor :name, :title
  attr_writer :earnings

  def initialize(name, title)
    @name = name
    @title = title
    @earnings = 0
  end

  def pay(number)
    @earnings += number
  end
end
