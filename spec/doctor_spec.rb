require('rspec')
require('doctor')
require('spec_helper')
require('patient')
require("pg")

  DB = PG.connect({:dbname => 'test_doctor'})

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM doctor *;")
    end
  end

describe(Doctor) do

  describe("#==") do
    it("is the same doctor if it has the same name") do
      doctor1 = Doctor.new({:name => "Steve", :specialty => "Gynocologist", :id => nil})
      doctor2 = Doctor.new({:name => "Steve", :specialty => "Gynocologist", :id => nil})
      expect(doctor1).to(eq(doctor2))
    end
  end

  before() do
    Doctor.clear()
  end



  describe('#name') do
    it('returns the name of the doctor') do
      doctor = Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => nil})
      expect(doctor.name()).to(eq("Dr Alysa"))
    end
  end

  describe('#specialty') do
    it('returns the specialty of the doctor') do
      doctor = Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => nil})
      expect(doctor.specialty()).to(eq("Podiatrist"))
    end
  end

  describe('#save') do
    it('saves instance to an array') do
      doctor = Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => nil})
      doctor.save()
      expect(Doctor.all()).to(eq([doctor]))
    end
  end

  describe('.all') do
    it('begins empty') do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#id") do
    it("displays the id of a doctor after saving") do
      doctor = Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => nil})
      doctor.save()
      expect(doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end

  # describe('.find') do
  #   it('returns the doctor by her id number') do
  #     test_doctor =`` Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => 1})
  #     test_doctor.save()
  #     test_doctor2 = Doctor.new({:name => "Dr Brian", :specialty => "Dermatologist", :id => 2})
  #     expect(Doctor.find(test_doctor.id())).to(eq(test_doctor))
  #   end
  # end

  describe('#add_patient') do
    it('adds a patient to the doctor clients list') do
      test_doctor = Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => 1})
      test_patient = Patient.new({:name => "Steve", :birthdate => "1985-07-13", :id => 1})
      test_doctor.add_patient(test_patient)
      expect(test_doctor.patients()).to(eq([test_patient]))
    end
  end
end

DB = PG.connect({:dbname => 'test_doctor'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patient *;")
  end
end

describe(Patient) do
  # before() do
  #   Patient.clear()
  # end

  describe("#==") do
    it("is the same list if it has the same name") do
      test_patient1 = Patient.new({:name => "Steve", :birthdate => "1985-07-13", :id => 1})
      test_patient2 = Patient.new({:name => "Steve", :birthdate => "1985-07-13", :id => 1})
      expect(test_patient1).to(eq(test_patient2))
    end
  end

  describe('#name') do
    it('returns the name of the test_patient') do
      test_patient = Patient.new({:name => "Steve", :birthdate => "1985-07-13", :id => 1})
      expect(test_patient.name()).to(eq("Steve"))
    end
  end

  describe('#birthdate') do
    it('returns the specialty of the test_patient') do
      test_patient = Patient.new({:name => "Steve", :birthdate => "1985-07-13", :id => 1})
      expect(test_patient.birthdate()).to(eq("1985-07-13"))
    end
  end

  describe('#doctor_id') do
    it("let you read the doctor ID out") do
      test_patient = Patient.new({:name => "Steve", :birthdate => "1985-07-13", :id => 1})
      expect(test_patient.doctor_id()).to(eq(1))
    end
  end

  describe("#id") do
    it("displays the id of a test_patient after saving") do
      test_patient = Patient.new({:name => "Steve", :birthdate => "1985-07-13", :id => 1})
      test_patient.save()
      expect(test_patient.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#save') do
    it('saves instance to an array') do
      test_patient = Patient.new({:name => "Steve", :birthdate => "Podiatrist", :id => 1})
      test_patient.save()
      expect(Patient.all()).to(eq([test_patient]))
    end
  end

  describe('.all') do
    it('begins empty') do
      expect(Patient.all()).to(eq([]))
    end
  end
end
