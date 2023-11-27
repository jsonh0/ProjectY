desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  if Rails.env.development?
    ActiveRecord::Base.transaction do
     
      Access.destroy_all
      User.destroy_all
      
      ImmigrationCase.destroy_all
      ForeignNational.destroy_all
      Account.destroy_all
      
    end
  end

  #creating Alice
  User.create(

    username: "Alice",
    email: "alice@example.com",
    password: "password",
    admin: true,

  )
  
  puts "created user alice"

  #need to add more users & access


  #creating accounts
  12.times do
    name = Faker::Games::WorldOfWarcraft.race
    note = Faker::Games::WorldOfWarcraft.quote
    acc = Account.create(
      name: name,
      notes: note
    )
  end
  
  puts "Created #{Account.count} accounts"

  Account.all.each do |account|
    rand(0..5).times do
      fn = ForeignNational.create(
        name: Faker::Games::WorldOfWarcraft.hero,
        address: Faker::Address.full_address,
        status: rand(0..4),
        birthday: Faker::Date.birthday(min_age: 5, max_age: 105),
        account_id: account.id
      )
    end
  end

  puts "Created #{ForeignNational.count} fns"

  
  receipt_codes = ["SRC", "LIN", "NBC", "WAC", "MSC"]
  rn = "#{receipt_codes.sample}-#{rand(100..999)}-#{rand(100..999)}-#{rand(1000..9999)}"

  ForeignNational.all.each do |fn|
    rand(0..4).times do
  
      status = rand(0..6)
      date = Faker::Date.forward(days: rand(20..100))
      c = ImmigrationCase.create(
        case_type: rand(0..5),
        foreign_nationals_id: fn.id,
        status: status,
        if status >= 2
          sent_date: date,
          if status > 2 && rand < 0.5
            received_date: date + 3,
            receipt_number: rn,
          end
        end
        if status == 5
          approval_date: date + 180,
          expiration_date: date >> 24,
        end

      )
    end 
  end
  puts "Created #{ImmigrationCase.count} immigration cases"
  

end
