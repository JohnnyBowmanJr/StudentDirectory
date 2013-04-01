require 'rubygems'
require 'yaml'
require 'pry'

class Person
  attr_accessor :name
  attr_accessor :email
  attr_accessor :github_user
  attr_accessor :twitter
  attr_accessor :fun_fact
  attr_accessor :ask_questions

  def buncha_questions
    print "What is your name? "
    self.name = gets.strip.chomp
    print "What is your email? "
    self.email = gets.strip.chomp
    print "What is your github handle? "
    self.github_user = gets.strip.chomp
    print "What is your twitter handle? "
    self.twitter = gets.strip.chomp
    print "Lemme know a fun fact about yourself? "
    self.fun_fact = gets.strip.chomp
  end
end

class Student < Person
  attr_accessor :reason_for_joining
  attr_accessor :tv
  
  def initialize
    print "What is your favorite T.V. show? "
    self.tv = gets.strip.chomp
    print "What's your reason for joining? "
    self.reason_for_joining = gets.strip.chomp
  end
  
end

class Instructor < Person
  attr_accessor :type

  def initialize
    print "What sort of instructor are you? "
    self.type = gets.strip.chomp
  end
end

@directory = []
puts "Student Directory, v0.0.2 by Johnny Bowman"
print "Enter Student or Instructor,  to load the directory, or q to save and quit: "

while ((input = gets.strip.chomp) != 'q') do

  case input
    when 'Student' 
      person = Student.new
      person.buncha_questions
      @directory << person

    when 'Instructor'
      person = Instructor.new
      person.buncha_questions
      @directory << person

    when "l"
      @directory << YAML.load_documents(File.open('student_directory.yml'))

  end

  
  # Append this to our yaml file
   
  puts @directory
  
  print "Enter Student or Instructor, l to load the Directory, or q to save and quit: "
end
# Open a student_directory.yml YAML file and write it out on one line

# Save people to a YAML file
File.open('student_directory.yml', 'a') { |f|
  @directory.compact.each do |person|
    f.write(person.to_yaml)
  end 
}

