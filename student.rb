class Student < Person
  attr_accessor :reason_for_joining

  # Prompt the user for questions, including those extra quetions pertaining to 
  # Student objects
  
  def ask_questions
    super
    print "What was your reason for joining? "
    self.reason_for_joining = gets.strip.chomp
  end

  # Provides a String that represents this Student, try me with puts!
  # 
  def to_s
    "ID: #{self.id}
    Type: #{self.class}
    Name: #{self.name}
    Email: #{self.email}
    Reason For Joining: #{self.reason_for_joining}"
  end

  # TODO - Persists this Instructor object to the database
  #
  def save
    # Build a String of SQL, that will insert all the attributes into the persons table
    sql = "insert into people (type, name, email, reason_for_joining) values (?, ?, ?, ?)"
    # Execute the SQL and provide the actual values
    
    @@db.execute(sql, self.class.to_s, name, self.email, self.reason_for_joining)
    
    # Execute the SQL on the @@db object
  end

end

