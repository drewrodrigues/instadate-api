ActiveRecord::Base.transaction do
  User.destroy_all
end