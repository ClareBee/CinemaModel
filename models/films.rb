require_relative ("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :genre, :price

  def initialize(details)
    @id = details['id'].to_i
    @title = details['title']
    @genre = details['genre']
    @rating = details['rating']
    @price = details['price'].to_i
  end

  def save()
    sql = "INSERT INTO films(
    title,
    genre,
    price
    ) VALUES (
    $1, $2, $3
    )
    RETURNING id;"
    values = [@title, @genre, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.select_all()
    sql = "SELECT * FROM films;"
    values = []
    result = SqlRunner.run(sql, values)
    return result.map {|film| Film.new(film)}
  end

  def find(id)
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [id]
    result = SqlRunner.run(sql, values)
    result_hash = result.first
    result = Film.new(result_hash)
    return result
  end

  def update()
    sql = "UPDATE films SET(
    title,
    price)
    = (
      $1, $2, $3
    ) WHERE id = $4;"
    values = [@title, @genre, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete(id)
    sql = "DELETE FROM films WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    values = []
    SqlRunner.run(sql, values)
  end


  def self.sort_by_title()
    sql = "SELECT films.* FROM films ORDER BY title;"
    values = []
    result = SqlRunner.run(sql, values)
    return result.map {|film| Film.new(film).title}
  end

  def self.available_genres
    sql = "SELECT"
  end


  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|customer| Customer.new(customer)}
  end

  def matching_time_slots()
    sql = "SELECT time_slots.* FROM time_slots INNER JOIN screenings ON time_slots.id = screenings.time_slot_id WHERE film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|slot| TimeSlot.new(slot)}
  end

  def matching_days()
    sql = "SELECT time_slots.* FROM time_slots INNER JOIN screenings ON time_slots.id = screenings.time_slot_id WHERE film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|slot| TimeSlot.new(slot).day_of_week}
  end

  def audience_size()
    customers.length
  end

  def screenings()
    sql = "SELECT screenings.* FROM screenings WHERE screenings.film_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values).first
    return result
  end

end
