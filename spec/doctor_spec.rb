require('rspec')
require('doctor')
require('spec_helper')
require('patient')

describe(Doctor) do
  before() do
    Doctor.clear()
  end

  describe('#name') do
    it('returns the name of the doctor') do
      test_doctor = Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => 1})
      expect(test_doctor.name()).to(eq("Dr Alysa"))
    end
  end

  describe('#specialty') do
    it('returns the specialty of the doctor') do
      test_doctor = Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => 1})
      expect(test_doctor.specialty()).to(eq("Podiatrist"))
    end
  end

  describe('#save') do
    it('saves instance to an array') do
      test_doctor = Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => 1})
      test_doctor.save()
      expect(Doctor.all()).to(eq([test_doctor]))
    end
  end

  describe('.all') do
    it('begins empty') do
      expect(Doctor.all()).to(eq([]))
    end
  end

  describe("#id") do
    it("displays the id of a doctor after saving") do
      test_doctor = Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => 1})
      test_doctor.save()
      expect(test_doctor.id()).to(be >= 1)
    end
  end

  describe('.find') do
    it('returns the doctor by her id number') do
      test_doctor = Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => 1})
      test_doctor.save()
      test_doctor2 = Doctor.new({:name => "Dr Brian", :specialty => "Dermatologist", :id => 2})
      expect(Doctor.find(test_doctor.id())).to(eq(test_doctor))
    end
  end

  describe('#add_patient') do
    it('adds a patient to the doctor clients list') do
      test_doctor = Doctor.new({:name => "Dr Alysa", :specialty => "Podiatrist", :id => 1})
      test_patient = Patient.new({:name => "Steve", :birthdate => "1985-07-13", :id => 1})
      test_doctor.add_patient(test_patient)
      expect(test_doctor.patients()).to(eq([test_patient]))
    end
  end

end

describe(Patient) do
  before() do
    Patient.clear()
  end


  describe('#name') do
    it('returns the name of the patient') do
      test_patient = Patient.new({:name => "Steve", :birthdate => "1985-07-13", :id => 1})
      expect(test_patient.name()).to(eq("Steve"))
    end
  end

  describe('#birthdate') do
    it('returns the specialty of the patient') do
      test_patient = Patient.new({:name => "Steve", :birthdate => "1985-07-13", :id => 1})
      expect(test_patient.birthdate()).to(eq("1985-07-13"))
    end
  end

  describe("#id") do
    it("displays the id of a patient after saving") do
      test_patient = Patient.new({:name => "Steve", :birthdate => "1985-07-13", :id => 1})
      test_patient.save()
      expect(test_patient.id()).to(be >= 1)
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
