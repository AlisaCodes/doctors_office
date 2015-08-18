require('rspec')
require('doctor')
require('pg')
require('patient')

DB = PG.connect({:dbname => 'test_doctor'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctor *;")
    DB.exec("DELETE FROM patient *;")
  end
end
