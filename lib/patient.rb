class Patient
  attr_reader(:name, :birthdate, :id)

  @@patients = []

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @birthdate = attributes.fetch(:birthdate)
    @id = attributes.fetch(:id)
  end

  define_method(:save) do
    @@patients.push(self)
  end

  define_singleton_method(:clear) do
    @@patients.clear()
  end

  define_singleton_method(:all) do
    @@patients
  end
end
