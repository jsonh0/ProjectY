desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  if Rails.env.development?
    ActiveRecord::Base.transaction do
      User.destroy_all
    end
  end
  User.create(

    username: "Alice",
    email: "alice@example.com",
    password: "password",
    admin: true,

  )
  
  puts "created user alice"
end
