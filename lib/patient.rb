class Patient
  attr_reader(:name, :birthdate, :id)

  @@patients = []
  patient = []

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    # @@patients.push(self)

    result = DB.exec("INSERT INTO patient (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
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
      id = patient.fetch("id").to_i()
      patients.push(Patient.new({:name => name, :id => id}))
    end
    patients
  end

  define_method(:==) do |another_patient|
    self.name().==(another_patient.name()).&(self.id().==(another_patient.id()))
  end
end
