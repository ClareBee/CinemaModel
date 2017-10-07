require_relative ("../db/sql_runner")
require_relative ("./films")
require_relative("./customers")
require_relative("./screenings")


class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id

  def initialize(details)
    @id = details['id'].to_i
    @film_id = details['film_id'].to_i
    @customer_id = details['customer_id'].to_i
    @screening_id = details['screening_id'].to_i
  end

  def save()
    sql = "INSERT INTO tickets (
    film_id,
    customer_id,
    screening_id
    )
    VALUES (
    $1, $2, $3
    )
    RETURNING id;"
    values = [@film_id, @customer_id, @screening_id]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE tickets SET (
    film_id,
    customer_id,
    screening_id
    ) =
    (
      $1, $2, $3
      ) WHERE id = $4;"
    values = [@film_id, @customer_id, @screening_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM tickets WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.select_all()
    sql = "SELECT * FROM tickets;"
    values = []
    results = SqlRunner.run(sql, values)
    return results.map {|ticket| Ticket.new(ticket)}
  end

  def self.delete_all()
    sql = "DELETE FROM tickets;"
    values = []
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [@customer_id]
    customer = SqlRunner.run(sql, values).first
    return Customer.new(customer)
  end
#what is really happening when we pass customer into Customer.new?
  def films()
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [@film_id]
    film = SqlRunner.run(sql, values).first
    return Film.new(film)
  end

  def screenings()
    sql = "SELECT * FROM screenings WHERE id = $1;"
    values = [@screening_id]
    screening = SqlRunner.run(sql, values).first
    return Screening.new(screening)
  end

#this was an alternative function to customer.buy_ticket
  def sell(customer, screening)
    if screening.capacity > 0
      customer.funds -= screening.films.price
      customer.update
      screening.capacity -= 1
      screening.update
      sql = "INSERT INTO tickets (
      film_id,
      customer_id
      )
      VALUES (
      $1, $2
      )
      RETURNING id;"
      values = [screening.films.id, customer.id]
      result = SqlRunner.run(sql, values).first
      @id = result['id'].to_i
    else
      return
      "this screening is unavailable"
    end
  end

end
