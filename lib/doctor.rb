class Doctor
  attr_reader(:name, :specialty, :id)

  @@doctors = []
  doctors = []

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @doctor_id = attributes.fetch(:id)
    @patients = []
  end

  define_method(:==) do |another_doctor|
    self.name().==(another_doctor.name())
  end

  define_method(:patients) do
    @patients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctor (name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")

    @id = result.first().fetch("id").to_i()
  end

  define_method(:add_patient) do |patient|
    @patients.push(patient)
  end

  define_singleton_method(:clear) do
    @@doctors.clear()
  end

  define_singleton_method(:all) do
    # @@doctors
    returned_doctors = DB.exec("SELECT * FROM doctor;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty = doctor.fetch("specialty")
      doctor_id = doctor.fetch("id").to_i()

      doctors.push(Doctor.new({:name => name, :specialty => specialty, :id => id}))
    end
    doctors
  end


  define_singleton_method(:find) do |doctor_id|
    found_doctor = nil
    @@doctors.each() do |doctor|
      if doctor.id == doctor_id
        found_doctor = doctor
      end
    end
    found_doctor
  end
end
