require_relative ("../db/sql_runner")
require_relative ("./films")

class Screening

  attr_reader :id
  attr_accessor :film_id, :capacity, :time_of_day, :hour, :day_of_week

  def initialize(details)
    @id = details['id'].to_i
    @film_id = details['film_id'].to_i
    @capacity = details['capacity'].to_i
    @time_of_day = details['time_of_day']
    @hour = details['hour']
    @day_of_week = details['day_of_week']
  end

  def save()
    sql = "INSERT INTO screenings (
    film_id,
    capacity,
    time_of_day,
    hour,
    day_of_week
    )
    VALUES (
      $1, $2, $3, $4, $5
    )
    RETURNING id;"
    values = [@film_id, @capacity, @time_of_day, @hour, @day_of_week]
    results = SqlRunner.run(sql, values).first
    @id = results['id'].to_i
  end

  def update()
    sql = "UPDATE screenings SET (
    film_id,
    capacity,
    time_of_day,
    hour,
    day_of_week
    ) = (
      $1, $2, $3, $4, $5
    ) WHERE id = $6;"
    values = [@film_id, @capacity, @time_of_day, @hour, @day_of_week, @id]
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


  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1;"
    values = [@film_id]
    result = SqlRunner.run(sql, values)
    return result.map {|customer| Customer.new(customer)}
  end

  def audience_size()
      customers.length
  end
  
  def update_capacity()
    @capacity -= customers.length
    update()
    return @capacity
  end

#functions still to write
  def self.popular(film)
     #find the number of customers for each screening of a given film and return the largest

  end

  def self.customers(film)
    sql = "SELECT COUNT(customers.id) FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE tickets.film_id = $1;"
    values = [film]
    result = SqlRunner.run(sql, values)
    return result.map {|customer| Customer.new(customer)}
  end

  def tickets
    sql = "SELECT tickets.* FROM tickets WHERE film_id = $1;"
    values = [@film_id]
    results = SqlRunner.run(sql, values)
    return results.map {|ticket| Ticket.new(ticket)}
  end
end
