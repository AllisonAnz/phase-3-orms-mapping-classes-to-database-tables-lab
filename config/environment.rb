require 'bundler'
Bundler.require

require_relative '../lib/student'

DB = {:conn => SQLite3::Database.new("db/students.db")}

# Your connection to the database can be referred to throughout your program 
# like this DB[:conn]

student = Student.create(name: "Elvis", grade: "9th")
p student #=> #<Student:0x00007fffc2248af0 @id=4, @name="Elvis", @grade="9th">
puts student.name #=> Elvis
puts student.grade #=> 9th