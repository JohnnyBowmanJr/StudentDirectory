class Instructor < Person
  attr_accessor :iq

  # Prompt the user for questions, including those extra quetions pertaining to 
  # Instructor objects
  #
  def ask_questions
    super
    print "What is your IQ? "
    self.iq = gets.strip.chomp
  end

  # Provides a String that represents this Student, try me with puts!
  #
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
    sql = "insert into people (type, name, email, reason_for_joining) values (?, ?, ?, ?)"
    # Execute the SQL and provide the actual values

    @@db.execute(sql, self.class.to_s, self.name, self.email, self.iq)  
  end
end
