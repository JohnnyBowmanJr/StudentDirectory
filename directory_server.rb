require 'sinatra'
require 'rubygems'
require 'shotgun'
require 'pry'
require 'rack-flash'
require 'sqlite3'

require_relative 'student_directory.rb'
require_relative 'instructor.rb'
require_relative 'student.rb'
require_relative 'person.rb'

enable :sessions
use Rack::Flash

get '/' do
  erb :index
end


# before '/' do
# 	unless params[:password] == "p"
# 		redirect :login
# 	end
# end

# post '/login' do
# 	if params[:password] == "p"
# 		redirect '/index'
# 	else
# 		flash[:notice] = "That's not the password, silly"
# 		redirect '/login'
# 	end
# end


# post '/film' do
#   db = SQLite3::Database.new("movies.db")

#   films = db.execute("select * from movies where title = '#{params[:name]}'")
#   if films.length > 0 	
#   	puts "Cache HIT"
#   	#db_film = films.first
#   	db_film = films.first
#   	film = Movie.get_film_from_db_info(db_film)
#   	# Use the film info from the database
#   elsif Movie.get_film_info((params[:name].gsub(" ","%20")))
#   	puts "Cache MISS"
#   	# Lookup the film information on the web
#     spacefix = params[:name].gsub(" ","%20")
#     film = Movie.get_film_info(spacefix)
#     # store the film in the database
#     film.save
#   else
#   	error 404 
#   end
# 	erb :film, :locals => {:film => film}
# end

# get '/index' do
# 	erb :index
# end

# get '/film' do 
# 	unless params[:name]
# 		redirect 'login'
# 	end
# 	erb :film
# end

# get '/login' do
# 	erb :login
# end

# not_found do
#     erb :error
# end



