ActiveRecord::Base.transaction do
  User.destroy_all
  Sex.destroy_all
  Outcome.destroy_all

  %w[male female].each do |sex|
    Sex.create!(name: sex)
  end
  puts "Created #{Sex.count} sexes"

  %w[hookup relationship dating].each do |outcome|
    Outcome.create!(name: outcome)
  end
  puts "Created #{Outcome.count} outcomes"
end