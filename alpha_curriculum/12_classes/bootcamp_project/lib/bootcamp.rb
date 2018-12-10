class Bootcamp
  @teachers
  @students
  @grades

  def initialize(name, slogan, student_capacity)
    @name = name
    @slogan = slogan
    @student_capacity = student_capacity
    @teachers = []
    @students = []
    @grades = Hash.new { |hash, k| hash[k] = []}
  end

  def name
    @name
  end

  def name=(new_name)
    @name = new_name
  end

  def slogan
    @slogan
  end

  def slogan=(new_slogan)
    @slogan = new_slogan
  end

  def student_capacity
    @student_capacity
  end

  def student_capacity=(new_cap)
    @student_capacity = new_cap
  end

  def teachers
    @teachers
  end

  def students
    @students
  end

  def hire(new_teacher)
    @teachers << new_teacher
  end

  def enroll(new_student)
    if @students.length < student_capacity
      @students << new_student
      true
    else
      false
    end
  end

  def enrolled?(student)
    @students.include?(student)
  end

  def student_to_teacher_ratio
    (@students.length/@teachers.length).floor
  end

  def add_grade(student, grade)
    if enrolled?(student)
      @grades[student] << grade
      true
    else
      false
    end
  end

  def num_grades(student)
    @grades[student].length
  end

  def average_grade(student)
    if enrolled?(student) && num_grades(student) > 0
      sum = 0
      @grades[student].each do |grade|
        sum += grade
      end
      sum / num_grades(student)
    else
      nil
    end
  end

end
