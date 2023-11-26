desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  if Rails.env.development?
    ActiveRecord::Base.transaction do
     
      Access.destroy_all
      User.destroy_all
      Account.destroy_all
      ForeignNational.destroy_all
      ImmigrationCase.destroy_all
    end
  end
  User.create(

    username: "Alice",
    email: "alice@example.com",
    password: "password",
    admin: true,

  )
  
  puts "created user alice"

  12.times do
    name = Faker::Games::WorldOfWarcraft.race
    note = Faker::Games::WorldOfWarcraft.quote
    acc = Account.create(
      name: name,
      note: note
    )
  end
  
  puts "Created #{Account.count} accounts"


end
