require 'rubygems'
require 'sqlite3'
require 'pry'

# Pull in each of our class files
require_relative 'person'
require_relative 'student'
require_relative 'instructor'

# Now the program actually starts here.
#
begin
  @@db = Person.open_database "student_directory.db"
  puts "Student Directory, v0.0.3 by Dan Garland"
  print 'Enter Student or Instructor, p to print, s to search, q to quit: '

  while ((input = gets.strip.chomp) != 'q') do
    case input
    when 'p'
      results = @@db.execute("select * from people")
      results.each do |row|
        puts row
      end
    when 's'
      # Ask the user to enter a search term
      print "Please enter the search term that you're looking for: "
      search = gets.strip.chomp
      # Find all the people who's name matches the given string
      # and print out their information
      search_result = @@db.execute("select * from people where name like '%#{search}%'")
      binding.pry
      search_result.each do |row|
        puts row
      end
    
    else
      # Create either a Student or Instructor object, depending on the input
      person = Person.create_person(input)
      unless person.nil?
        # Prompt the user for information about a Person
        person.ask_questions
        # Save someone in our database
        person.save
      end 
    end
    
    print 'Enter Student or Instructor, p to print, s to search, q to quit: '
  end
rescue Exception => e
  puts "Error ! #{e}"
  puts "#{e.backtrace.join "\n"}"
ensure
  # Ensure that the database is closed before we go
  Person.close_database
end