require 'sqlite3'

class Instructor
  attr_accessor :iq
  attr_accessor :name
  attr_accessor :email

  def assign_values(name, email, iq)
    self.name  = name
    self.email = email
    self.iq = iq
    self.save
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
