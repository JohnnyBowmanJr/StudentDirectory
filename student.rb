require 'rubygems'
require 'yaml'

class Person
  attr_accessor :name
  attr_accessor :email
  attr_accessor :github_user
  attr_accessor :twitter
  attr_accessor :fun_fact
  attr_accessor :ask_questions

  def self.ask_questions(person)
    print "What is your name? "
    person.name = gets.strip.chomp
    print "What is your email? "
    person.email = gets.strip.chomp
    print "What is your github handle? "
    person.github_user = gets.strip.chomp
    print "What is your twitter handle? "
    person.twitter = gets.strip.chomp
    print "Lemme know a fun fact about yourself? "
    person.fun_fact = gets.strip.chomp
  end
end

class Student < Person
  attr_accessor :reason_for_joining
  attr_accessor :tv
end

class Instructor < Person
  attr_accessor :type
end

@directory = ""
puts "Student Directory, v0.0.2 by Johnny Bowman"
print "Enter Student or Instructor, q to save and quit: "

while ((input = gets.strip.chomp) != 'q') do

  person = nil
  case input
  when 'Student' 
    person = Student.new
    Person.ask_questions(person)
    print "What is your favorite T.V. show? "
    person.tv = gets.strip.chomp
    print "What's your reason for joining? "
    person.reason_for_joining = gets.strip.chomp
    
  when 'Instructor'
    person = Instructor.new
    Person.ask_questions(person)
    print "What sort of instructor are you? "
    person.type = gets.strip.chomp
  end
  
  # Append this to our yaml file
  @directory += person.to_yaml
  puts @directory
  
  print "Enter Student or Instructor, q to save and quit: "
end

# Open a student_directory.yml YAML file and write it out on one line
File.open('student_directory.yml', 'a') { |f| f.write(@directory) } 
