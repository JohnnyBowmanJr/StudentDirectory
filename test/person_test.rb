require 'test/unit'
require 'sqlite3'
require 'pry'
require_relative '../person'
require_relative '../student'
require_relative '../instructor'

class PersonTest < Test::Unit::TestCase

  def setup
    Person.open_database "test/test.db"
  end

  def test_all_method_gives_me_all_people
    people = Person.all
    assert_equal 2, people.length

    # Test that the first record can be retrieved
    assert_equal 1, people[0].id  
    assert_equal Instructor, people[0].class
    assert_equal "Dan", people[0].name
    assert_equal "dan@dangarland.co.uk", people[0].email
    assert_equal 300, people[0].iq

    # Test that the second record can be retrieved
    assert_equal 2, people[1].id
    assert_equal Student, people[1].class
    assert_equal "Sally", people[1].name
    assert_equal "sally@gmail.com", people[1].email
    assert_equal "I love coding", people[1].reason_for_joining
  end

  def test_find_by_name_gives_me_the_right_person
    people = Person.find_by_name("Dan")
      
    assert_equal 1, people[0].id
    assert_equal "Dan", people[0].name

    people = Person.find_by_name("Sally")
    assert_equal 1, people.length
    assert_equal 2, people[0].id
    assert_equal "Sally", people[0].name

    people = Person.find_by_name("Algernon")
    assert_not_nil people
    assert_equal 0, people.length
  end

  def test_find_by_name_handles_partial_match
    people = Person.find_by_name("a")
    assert_equal 2, people.length
    assert_equal "Dan", people[0].name
    assert_equal "Sally", people[1].name
  end

  def teardown
    Person.close_database
  end

end