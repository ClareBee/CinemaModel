require ("pry-byebug")
require_relative ("../models/customers")
require_relative ("../models/films")
require_relative ("../models/screenings")
require_relative ("../models/tickets")


Customer.delete_all
Film.delete_all
Screening.delete_all
Ticket.delete_all

customer1 = Customer.new({
  'name' => "Sally Smith",
  'funds' => 10
})
customer1.save()

customer2 = Customer.new({
  'name' => "Peter Piper",
  'funds' => 30
})
customer2.save()

customer3 = Customer.new({
  'name' => "Joe Bloggs",
  'funds' => 20
})
customer3.save()

customer4 = Customer.new({
  'name' => "Christopher Jones",
  'funds' => 25
  })
customer4.save()

customer5 = Customer.new({
  'name' => "Sarah Jones",
  'funds' => 20
  })
customer5.save()

film1 = Film.new({
  'title' => "Casablanca",
  'genre' => "drama",
  'rating' => "PG",
  'price' => 5
})
film1.save()

film2 = Film.new({
  'title' => "Blade Runner",
  'genre' => "science fiction",
  'rating' => "15",
  'price' => 7
})
film2.save()

film3 = Film.new({
  'title' => "The Lego Movie: Ninjago",
  'genre' => "animation",
  'rating' => "U",
  'price' => 5
})
film3.save()

film4 = Film.new({
  'title' => "The Glass Castle",
  'genre' => "drama",
  'rating' => "PG",
  'price' => 5
  })
film4.save()


screening1 = Screening.new({
    'film_id' => film1.id,
    'capacity' => 20,
    'time_of_day' => "afternoon",
    'hour' => '14:00:00',
    'day_of_week' => "Monday"
})
screening1.save()

screening2 = Screening.new({
  'film_id' => film2.id,
  'capacity' => 30,
  'time_of_day' => "morning",
  'hour' => '10:00:00',
  'day_of_week' => "Tuesday"
})
screening2.save()

screening3 = Screening.new({
  'film_id' => film2.id,
  'capacity' => 30,
  'time_of_day' => "afternoon",
  'hour' => '14:00:00',
  'day_of_week' => "Tuesday"
})
screening3.save()

screening4 = Screening.new({
  'film_id' => film3.id,
  'capacity' => 20,
  'time_of_day' => "evening",
  'hour' => '20:00:00',
  'day_of_week' => "Tuesday"
})
screening4.save()

screening5 = Screening.new({
  'film_id' => film3.id,
  'capacity' => 30,
  'time_of_day' => "morning",
  'hour' => '10:00:00',
  'day_of_week' => "Wednesday"
})
screening5.save()

screening6 = Screening.new({
  'film_id' => film4.id,
  'capacity' => 30,
  'time_of_day' => "evening",
  'hour' => '20:00:00',
  'day_of_week' => "Wednesday"
})
screening6.save()

screening7 = Screening.new({
  'film_id' => film4.id,
  'capacity' => 25,
  'time_of_day' => "afternoon",
  'hour' => '12:00:00',
  'day_of_week' => "Thursday"
})
screening7.save()

screening8 = Screening.new({
  'film_id' => film1.id,
  'capacity' => 30,
  'time_of_day' => "evening",
  'hour' => '20:00:00',
  'day_of_week' => "Friday"
})
screening8.save()

screening9 = Screening.new({
  'film_id' => film2.id,
  'capacity' => 30,
  'time_of_day' => "afternoon",
  'hour' => '12:00:00',
  'day_of_week' => "Saturday"
})
screening9.save()

screening10 = Screening.new({
  'film_id' => film2.id,
  'capacity' => 30,
  'time_of_day' => "evening",
  'hour' => '20:00:00',
  'day_of_week' => "Saturday"
})
screening10.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id
})
ticket1.save()

ticket2 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film2.id
})
ticket2.save()

ticket3 = Ticket.new({
  'customer_id' => customer2.id,
  'film_id' => film3.id
  })
ticket3.save()

ticket4 = Ticket.new({
  'customer_id' => customer3.id,
  'film_id' => film3.id
  })
ticket4.save()

ticket5 = Ticket.new({
  'customer_id' => customer4.id,
  'film_id' => film4.id
  })
ticket5.save()

ticket6 = Ticket.new({
  'customer_id' => customer5.id,
  'film_id' => film4.id
  })
binding.pry
nil
