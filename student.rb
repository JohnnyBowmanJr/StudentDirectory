class Student
  attr_accessor :name
  attr_accessor :email
  attr_accessor :reason

  # Provides a String that represents this Student, try me with puts!
  # 
  def assign_values(name, email, reason)
    self.name  = name
    self.email = email
    self.reason = reason
    self.save
  end

  def save
    @@db = SQLite3::Database.new("student_directory.db")
    # Build a String of SQL, that will insert all the attributes into the persons table
    sql = "insert into people (type, name, email, reason_for_joining) values (?, ?, ?, ?)"
    # Execute the SQL and provide the actual values
    
    @@db.execute(sql, self.class.to_s, name, self.email, self.reason)

  end

end

