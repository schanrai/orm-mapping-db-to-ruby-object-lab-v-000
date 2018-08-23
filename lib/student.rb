class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    # create a new Student object in Ruby given a row from the database
    #row is an array
      new_student = self.new  # self.new is the same as running Student.new
      new_student.id = row[0]
      new_student.name =  row[1]
      new_student.grade = row[2]
      new_student  # return the newly created instance
  end

  def self.all
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
    sql = <<-SQL
      SELECT *
      FROM students
    SQL
    DB[:conn].exceute(sql).map do |row|
      binding.pry
      self.new_from_db(row)
    end
  end


  def self.find_by_name(name)
    # find the student in the database given a name
    # return a new instance of the Student class
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
end
