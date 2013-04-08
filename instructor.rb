require 'sqlite3'

class Instructor
  attr_accessor :iq
  attr_accessor :name
  attr_accessor :email

  # Prompt the user for questions, including those extra quetions pertaining to 
  # Instructor objects
  #

  # Provides a String that represents this Student, try me with puts!
  #
  def assign_values(name, email, iq)
    self.name  = name
    self.email = email
    self.iq = iq
    self.save
  end

  def to_s
    "ID: #{self.id}
    Type: #{self.class}
    Name: #{self.name}
    Email: #{self.email}
    IQ: #{self.iq}"
  end

  # TODO - Persists this Instructor object to the database
  #
  def save
    @@db = SQLite3::Database.new("student_directory.db")
    sql = "insert into people (type, name, email, iq) values (?, ?, ?, ?)"
    # Execute the SQL and provide the actual values

    @@db.execute(sql, self.class.to_s, self.name, self.email, self.iq)  
  end
end
