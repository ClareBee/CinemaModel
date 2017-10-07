require_relative ("../db/sql_runner")

class Film

  attr_reader :id
  attr_accessor :title, :genre, :rating, :price

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
    rating,
    price
    ) VALUES (
    $1, $2, $3, $4
    )
    RETURNING id;"
    values = [@title, @genre, @rating, @price]
    film = SqlRunner.run(sql, values).first
    @id = film['id'].to_i
  end

  def self.select_all()
    sql = "SELECT * FROM films;"
    values = []
    result = SqlRunner.run(sql, values)
    return result.map {|film| Film.new(film)}
  end

  def self.find(id)
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
      $1, $2, $3, $4
    ) WHERE id = $5;"
    values = [@title, @genre, @rating, @price, @id]
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

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|customer| Customer.new(customer)}
  end

  def matching_days()
    sql = "SELECT screenings.* FROM screenings WHERE film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|slot| Screening.new(slot).day_of_week}
  end

  def audience_size()
    customers.length
  end

  def screenings()
    sql = "SELECT screenings.* FROM screenings WHERE film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map{|screen| Screening.new(screen)}
  end

#is there a way in pry to return an array of hashes with film name => day of week?

#on psql this is = SELECT films.title, screenings.* FROM screenings INNER JOIN films ON films.id = screenings.film_id;

def self.all_screenings()
  sql = "SELECT films.title, screenings.* FROM screenings INNER JOIN films ON films.id = screenings.film_id;"
  values = []
  results = SqlRunner.run(sql, values)
  return results.map {|screen| Screening.new(screen)}
end

#this returns a hash of unique values, but how do i get rid of the keys?

  def self.all_available_genres
    sql = "SELECT genre FROM films;"
    values = []
    results = SqlRunner.run(sql, values)
    return results.map.uniq {|film| Film.new(film).genre}
  end

#how do i return a number off this??
  def ticket_count
    sql = "SELECT COUNT(id) FROM tickets WHERE film_id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    results_hash = results.first
    return results_hash['count']
  end
#still to write
  def popular_screening
  end
end
