require_relative 'contact'
require 'sinatra'

get '/' do
  erb :index
end

get '/contacts' do
  @contacts = Contact.all
  erb :contacts
end

get '/contacts/new' do

  erb :new
end

get '/contacts/:id' do
  #        = Contact.find_by(id: 1/2/3/4 whatever the url is taking)/
  #@contact =
  @contact = Contact.find_by({id: params[:id].to_i})
  if @contact
    erb :show_contact
  elsif
    raise Sinatra::NotFound
  end
end

get '/about' do
  @title = "About Me"
  @skills = skills = ["amazing", "Juggle", "Dave"]
  @interests = interests = ["hockey", "nutrition", "Fabio"]
   erb :about
end

get '/contacts/:id/edit' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound
  end
end

post '/contacts' do
  Contact.create(
    first_name: params[:first_name],
    last_name:  params[:last_name],
    email:      params[:email],
    note:       params[:note]
  )
  redirect to('/contacts')
end

put '/contacts/:id' do
  @contact = Contact.find_by(id: params[:id].to_i)
  if @contact
    @contact.update(
      first_name: params[:first_name],
      last_name:  params[:last_name],
      email:      params[:email],
      note:       params[:note]
    )

    redirect to ('/contacts')
  else
    raise Sinatra::NotFound
  end
end

after do
  ActiveRecord::Base.connection.close
end
