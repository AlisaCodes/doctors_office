class Patient
  attr_reader(:name, :birthdate, :doctor_id, :id)

  @@patients = []
  patients = []

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
    @id = attributes.fetch(:id, nil)
    @patients = []
    @doctor_id = attributes.fetch(:doctor_id)

  end



  define_method(:==) do |another_patient|
    self.name().==(another_patient.name()).&(self.doctor_id().==(another_patient.doctor_id()))
  end

  define_method(:patients) do
    @patients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO patient (name, birthdate, doctor_id) VALUES ('#{@name}', '#{@birthdate}', #{@doctor_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end



  define_singleton_method(:clear) do
    @@patients.clear()
  end

  define_singleton_method(:all) do
    # @@patients
    returned_patients = DB.exec("SELECT * FROM patient;")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch("name")
      birthdate = patient.fetch("birthdate")
      doctor_id = patient.fetch("doctor_id").to_i()

      patients.push(Patient.new({:name => name, :birthdate => birthdate, :doctor_id => doctor_id}))
    end
    patients
  end


  define_singleton_method(:find) do |patient_id|
    found_patient = nil
    @@patients.each() do |patient|
      if patient.id == patient_id
        found_patient = patient
      end
    end
    found_patient
  end
end
