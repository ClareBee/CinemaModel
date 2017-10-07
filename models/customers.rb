require_relative ("../db/sql_runner")


class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(details)
    @id = details['id'].to_i
    @name = details['name']
    @funds = details['funds'].to_i
    @tickets = []
  end

#create
  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES (
      $1, $2
    )
    RETURNING id;"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

#read
  def select()
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.first
  end
#update
  def update()
    sql = "UPDATE customers SET (
    name,
    funds
    ) = (
    $1, $2
    ) WHERE id = $3;"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end
#delete
  def delete()
    sql = "DELETE FROM customers WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.select_all()
    sql = "SELECT * FROM customers;"
    values = []
    result = SqlRunner.run(sql, values)
    return result.map {|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers;"
    values = []
    result = SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON films.id = tickets.film_id WHERE customer_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map {|film| Film.new(film)}
  end

  def tickets()
    sql = "SELECT tickets.* FROM tickets WHERE tickets.customer_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map {|purchase| Ticket.new(purchase)}
  end

  # def buy_ticket(film)
  #   @funds -= film.price
  #   update()
  # end
  #
  def buy_ticket(film, screening)
    if screening.capacity > 0
    screening.capacity -= 1
    screening.update
    #screening.update_capacity
    @funds -= film.price
    update()
    sql = "INSERT INTO tickets (
    film_id,
    customer_id
    ) VALUES (
      $1, $2
    ) RETURNING id;"
    values = [film.id, @id]
    #values = [screening.film_id, @id]
    result = SqlRunner.run(sql, values).first
    id = result['id'].to_i
    puts "The customer now has £#{@funds}"
    else
    puts "This screening is unavailable."
    end
  end

  def screenings()
    sql = "SELECT screenings.* FROM screenings INNER JOIN tickets ON screenings.film_id = tickets.film_id WHERE tickets.customer_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map {|show| Screening.new(show)}
  end

  # def total_tickets()
  #   sql = "SELECT tickets.* FROM tickets WHERE tickets.customer_id = $1;"
  #   values = [@id]
  #   result = SqlRunner.run(sql, values)
  #   array = result.map {|ticket| Ticket.new(ticket)}
  #   return array.length
  # end

  def total_tickets
    return tickets.length
  end

end
