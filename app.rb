require('sinatra')
require('sinatra/reloader')
require('./lib/doctor.rb')
require('./lib/patient.rb')
also_reload('lib/**/*.rb')
require("pg")

DB = PG.connect({:dbname => "doctor"})

get("/") do
  @doctors = Doctor.all()
  erb(:index)
end

post('/doctor/new') do
  name = params.fetch('name')
  specialty = params.fetch('specialty')
  Doctor.new({:name => name, :specialty => specialty}).save()
  @success_message = "#{name} has been added."
  @doctors = Doctor.all()
  erb(:index)
end
