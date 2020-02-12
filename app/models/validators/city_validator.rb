# frozen_string_literal: true

class CityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid_cities.include?(value)
      record.errors.add(attribute, 'is invalid')
    end
  end

  private

  def valid_cities
    @valid_cities ||= CS.states(:us).keys.flat_map do |state|
      CS.cities(state, :us).flat_map { |city| "#{city}, #{state}" }
    end
  end
end
