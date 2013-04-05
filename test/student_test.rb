require 'test/unit'
require 'sqlite3'
require 'pry'
require_relative '../person'
require_relative '../student'
require_relative '../instructor'

class StudentTest < Test::Unit::TestCase

  def setup
    Person.open_database "test/test.db"
  end

  def test_that_the_save_method_works
    begin
      Person.db.transaction
      student = Student.new
      student.name = "Susan"
      student.email = "susan@gmail.com"
      student.reason_for_joining = "I love coding too"
      student.save

      # If it worked, we should have one record in the people database called Susan
      results = Person.db.execute("select * from people where name = 'Susan'")
      assert_not_nil results
      assert_equal 1, results.length

    rescue
      raise
    ensure
      Person.db.rollback
    end
  end

  def teardown
    Person.close_database
  end
end