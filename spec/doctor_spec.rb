require('rspec')
require('doctor')
require('spec_helper')
  describe(Doctor) do
  # before() do
  #   Doctor.clear()
  # end

  describe('#name') do
    it('returns the name of the doctor') do
      test_doctor = Doctor.new({:name => "Dr Alysa"})
      expect(test_doctor.name()).to(eq("Dr Alysa"))
    end
  end
end
