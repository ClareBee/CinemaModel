require_relative ("../db/sql_runner")
class TimeSlot

  attr_reader :id
  attr_accessor :time_of_day, :hour, :day_of_week

  def initialize(details)
    @id = details['id'].to_i
    @time_of_day = details['time_of_day']
    @hour = details['hour']
    @day_of_week = details['day_of_week']
  end


  def save()
    sql = "INSERT INTO time_slots (
    time_of_day,
    hour,
    day_of_week
    )
    VALUES (
    $1, $2, $3
    )
    RETURNING id;"
    values = [@time_of_day, @hour, @day_of_week]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE time_slots SET (
    time_of_day,
    hour,
    day_of_week
    ) = (
    $1, $2, $3
    ) WHERE id = $4;"
    values = [@time_of_day, @hour, @day_of_week, @id]
    SqlRunner.run(sql, values)
  end

  def self.select_all()
    sql = "SELECT * FROM time_slots;"
    values = []
    results = SqlRunner.run(sql, values)
    return results.map {|slot| TimeSlot.new(slot)}
  end

  def delete()
    sql = "DELETE FROM time_slots WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM time_slots;"
    values = []
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films INNER JOIN screenings ON films.id = screenings.film_id WHERE screenings.time_slot_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    return result.map {|film| Film.new(film)}
  end


end
