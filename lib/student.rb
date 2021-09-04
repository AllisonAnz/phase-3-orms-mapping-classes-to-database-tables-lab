# Building an app to help administrators keep track of their students 
# We have a student class. 
# Each student will have two attributes, a name and grade (9th, 10th etc.)
# Remember, you can access your database connection anywhere in this class
#  with DB[:conn]  
class Student
  attr_accessor :name, :grade
  attr_reader :id 

  def initialize(name, grade, id=nil)
    @id = id
    @name = name 
    @grade = grade 
  end

  # creates the students table 
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

  #.drop_table: drops the students table from the database 
  def self.drop_table 
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  #save saves an instance of the Student class to a db 
   def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  # .create takes in a hash of attributes and uses metaprogramming to create a new student object 
  # then it uses the #save method to save the student to the db
  # returns the new object that it instantied 
  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
end

