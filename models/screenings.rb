require_relative ("../db/sql_runner")
require_relative ("./time_slots")
require_relative ("./films")

class Screening

  attr_reader :id
  attr_accessor :time_slot_id, :film_id, :capacity

  def initialize(details)
    @id = details['id'].to_i
    @time_slot_id = details['time_slot_id'].to_i
    @film_id = details['film_id'].to_i
    @capacity = details['capacity'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (
    time_slot_id,
    film_id,
    capacity
    )
    VALUES (
      $1, $2, $3
    )
    RETURNING id;"
    values = [@time_slot_id, @film_id, @capacity]
    results = SqlRunner.run(sql, values).first
    @id = results['id'].to_i
  end

  def update()
    sql = "UPDATE screenings SET (
    time_slot_id,
    film_id,
    capacity
    ) = (
      $1, $2, $3
    ) WHERE id = $4;"
    values = [@time_slot_id, @film_id, @capacity, @id]
    SqlRunner.run(sql, values)
  end

  def self.select_all()
    sql = "SELECT * FROM screenings;"
    values = []
    result = SqlRunner.run(sql, values)
    return result.map {|screening| Screening.new(screening)}
  end

  def delete()
    sql = "DELETE FROM screenings WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    values = []
    SqlRunner.run(sql, values)
  end


  def films()
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [@film_id]
    result = SqlRunner.run(sql, values).first
    return Film.new(result)
  end

  def time_slots()
    sql = "SELECT * FROM time_slots WHERE id = $1;"
    values = [@time_slot_id]
    result = SqlRunner.run(sql, values).first
    return TimeSlot.new(result)
  end

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map {|customer| Customer.new(customer)}
  end

  def update_capacity()
    @capacity -= customers.length
    update()
    return @capacity
  end

#functions still to write
  def most_popular_film()
  end

  def tickets
  end
end
