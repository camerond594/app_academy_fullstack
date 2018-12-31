require "employee"

class Startup
  attr_reader :name, :funding, :salaries, :employees

  def initialize(name, funding, salaries)
    @name = name
    @funding = funding
    @salaries = salaries
    @employees = []
  end

  def valid_title?(title)
    if @salaries[title] == nil
      return false
    end
    true
  end

  def hire(employee_name, title)
    if valid_title?(title)
      @employees << Employee.new(employee_name, title)
      return true
    else
      raise "title does not exist"
    end
  end

  def >(other_startup)
    return true if self.funding > other_startup.funding
    return false
  end

  def size
    @employees.length
  end

  def close
    @employees = []
    @funding = 0
  end

  def payday
    @employees.each do |employee|
      pay_employee(employee)
    end
  end

  def average_salary
    total_salaries = 0
    @employees.each do |employee|
      total_salaries += salaries[employee.title]
    end
    total_salaries / self.size
  end

  def acquire(other_startup)
    @funding += other_startup.funding

    other_startup.employees.each do |employee|
      @employees << employee
    end

    other_startup.salaries.each do |title, salary|
      if @salaries[title] == nil
        @salaries[title] = salary
      end
    end
    other_startup.close
    true
  end

  def pay_employee(employee)
    employee_salary = salaries[employee.title]
    if @funding >= employee_salary
      employee.pay(employee_salary)
      @funding -= employee_salary
    else
      raise "not enough funding"
    end
  end
end
