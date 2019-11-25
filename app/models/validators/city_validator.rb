class CityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add(attribute, 'is invalid') unless valid_cities.include?(value)
  end

  private

  def valid_cities
    @valid_cities ||= CS.states(:us).keys.flat_map do |state|
      CS.cities(state, :us).flat_map { |city| "#{city}, #{state}" }
    end
  end
end
