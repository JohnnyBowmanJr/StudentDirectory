require 'pry'
require 'sqlite3'

class Person
  attr_accessor :id
  attr_accessor :type
  attr_accessor :name
  attr_accessor :email
  
  # Get a reference to the database (HINT - don't need to change this)
  #
  def self.open_database(name)
    @@db = SQLite3::Database.new(name)

  end

  # Close the database (HINT - don't need to change this)
  #
  def self.close_database
    @@db.close
  end

  # Only used for the tests, don't need to call, you can just use @@db
  def self.db
    @@db
  end

  # Builds either a Student or an Instructor, depending on the value of type
  #
  def self.create_person(type)
    case type
    when 'Student' 
      Student.new
    when 'Instructor'
      Instructor.new
    else
      nil
    end
  end

  # TODO - Return an array of either Student or Instructor objects, using information
  # stored in the database

  def self.all
    people = []
    
    # Build a SQL String that will lookup all people in the database
    
    sql = "select * from people"
    
    # Execute the SQL on @@db
    result = @@db.execute(sql)
 
    result.each do |row|
      case row[1]
        when "Instructor"
          person = Instructor.new
          person.iq = row[5]
        when "Student"
          person = Student.new
          person.reason_for_joining = row[4]
        else
          nil
      end
        person.id = row[0]
        person.type = row[1]
        person.name = row[2]
        person.email = row[3]
        people << person
    end

   
    
    # Iterate through each result, and build either a Student or an Instructor,
    # filling in the information as you go.


    return people
  end

  # TODO - Return an array of either Student or Instructor objects, using information
  # stored in the database, where the name matches the given argument
  #
  def self.find_by_name(name)
    people = []
    
    
    # Build a SQL String that will lookup all people in the database
    # where the name matches
    sql = "select * from people where name like '%#{name}%'" 

    # Execute the SQL on @@db
    result  = @@db.execute(sql)

    result.each do |row|
      case row[1]
        when "Instructor"
          person = Instructor.new
          person.iq = row[5]
        when "Student"
          person = Student.new
          person.reason_for_joining = row[4]
        else
          nil
      end
        person.id = row[0]
        person.type = row[1]
        person.name = row[2]
        person.email = row[3]
        people << person
    end

    return people
  end

  # Prompt the user for some questions, common to all Person classes
  #
  def ask_questions
    print "What is your name? "
    self.name = gets.strip.chomp
    print "What is your email? "
    self.email = gets.strip.chomp
  end
end