require 'sinatra'
require 'rubygems'
require 'shotgun'
require "sinatra/reloader"
require 'pry'
require 'rack-flash'
require 'sqlite3'

require_relative 'instructor'
require_relative 'student'

enable :sessions
use Rack::Flash

before do
  unless session[:current_user]  || request.path == "/login"
    redirect '/login'
  end
end

get '/login' do
  erb :login
end

post '/login' do
  if params[:password] == "p"
    session[:current_user] = params[:username]
    redirect '/'
  else
    flash[:notice] = "That's not the password, silly"
    redirect '/login'
  end
end

get '/' do
  db = SQLite3::Database.new("student_directory.db")
  records = db.execute("select * from people")
  erb :index, :locals => {:records => records}
end

get '/search' do
  db = SQLite3::Database.new("student_directory.db")
  people = db.execute("select * from people where name like '%#{params[:name]}%'")
  erb :list, :locals => {:people => people}

end

get '/add' do
  erb :add
end

post '/add_instructor' do
   
  person = Instructor.new
  name = params[:name]
  email = params[:email]
  iq = params[:iq]
  person.assign_values(name, email, iq)
  redirect '/'
end

post '/add_student' do
  person = Student.new
  name = params[:name]
  email = params[:email]
  reason = params[:reason]
  person.assign_values(name, email, reason)
  redirect '/'
end

get '/remove' do
  db = SQLite3::Database.new("student_directory.db")
  records = db.execute("select * from people")
  erb :delete, :locals => {:records => records}
end

post '/remove' do
  db = SQLite3::Database.new("student_directory.db")

  delete_ids = []
  params[:id].each do |id|
    delete_ids << id.to_i
  end
  delete_ids = delete_ids.join(",")
  sql = "DELETE FROM people WHERE id IN ('#{delete_ids}')"
  db.execute(sql)
  redirect '/'
end






