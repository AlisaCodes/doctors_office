class Doctor
  attr_reader(:name, :specialty, :id)

  @@doctors = []
  doctors = []

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id, nil)
  end

  define_method(:save) do
    # @@doctors.push(self)

    result = DB.exec("INSERT INTO doctor (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
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
      id = doctor.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name, :specialty => specialty, :id => id}))
    end
    doctors
  end
  define_method(:==) do |another_doctor|
    self.name().==(another_doctor.name())
  end

  define_method(:list_patients)  do
    @id = self.id()
    all_patients = []
    patients = DB.exec("Select * FROM patient WHERE doctor_id=#{@id};")
    patients.each do |patient|
      name = patient.fetch('name')
      birthdate = patient.fetch('birthdate')
      doctor_id = patient.fetch('doctor_id').to_i()
      all_patients.push(Patient.new({:name => name, :birthdate => birthdate, :doctor_id => doctor_id}))
    end
    all_patients
  end
end
