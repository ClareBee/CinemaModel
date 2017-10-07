require ("pry-byebug")
require_relative ("../models/customers")
require_relative ("../models/films")
require_relative ("../models/screenings")
require_relative ("../models/tickets")
require_relative ("../models/time_slots")

Customer.delete_all
Film.delete_all
TimeSlot.delete_all
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

timeslot1 = TimeSlot.new({
  'time_of_day' => "morning",
  'hour' => '10:00:00',
  'day_of_week' => "Monday"
})
timeslot1.save()

timeslot2 = TimeSlot.new({
  'time_of_day' => "afternoon",
  'hour' => '14:00:00',
  'day_of_week' => "Tuesday"
})
timeslot2.save()

screening1 = Screening.new({
    'film_id' => film1.id,
    'time_slot_id' => timeslot1.id,
    'capacity' => 20
})
screening1.save()

screening2 = Screening.new({
  'film_id' => film2.id,
  'time_slot_id' => timeslot2.id,
  'capacity' => 30
})
screening2.save()

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

binding.pry
nil
