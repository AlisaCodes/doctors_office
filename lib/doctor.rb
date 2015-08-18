class Doctor
  attr_reader(:name, :specialty, :id)

  @@doctors = []

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id)
    @patients = []
  end
  define_method(:patients) do
    @patients
  end
  define_method(:save) do
    @@doctors.push(self)
  end
  define_method(:add_patient) do |patient|
    @patients.push(patient)
  end
  define_singleton_method(:clear) do
    @@doctors.clear()
  end
  define_singleton_method(:all) do
    @@doctors
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
