class Doctor
  attr_reader(:name)

  define_method(:initialize) do |attributes|
  @name = attributes.fetch(:name)
  # @specialty = attributes.fetch(:specialty)
  end




end
