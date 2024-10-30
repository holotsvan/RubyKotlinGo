require 'date'

class Student
  attr_reader :surname, :name, :date_of_birth

  @@students = []

  def initialize(name, surname, date_of_birth)
    @name = name
    @surname = surname
    @date_of_birth = validate_date_of_birth(date_of_birth)

    add_student if unique_student?
  end

  def calculate_age
    age = Date.today.year - @date_of_birth.year
    age -= 1 if Date.today < Date.new(@date_of_birth.year, @date_of_birth.month, @date_of_birth.day)
    age
  end

  def add_student
    @@students << self
  end

  def self.remove_student(student)
    @@students.delete(student)
  end

  def self.get_students_by_age(age)
    @@students.select { |student| student.calculate_age == age }
  end

  def self.get_students_by_name(name)
    @@students.select { |student| student.name == name }
  end

  def self.all_students
    @@students
  end

  def unique_student?
    @@students.none? { |student| student.name == @name && student.surname == @surname && student.date_of_birth == @date_of_birth }
  end

  def validate_date_of_birth(date_of_birth)
    parsed_date = Date.parse(date_of_birth)
    raise ArgumentError, "Date of birth must be in the past" if parsed_date >= Date.today

    parsed_date
  end
end