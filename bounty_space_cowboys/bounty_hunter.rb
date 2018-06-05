require('pg')

class BountyHunter

  attr_accessor :name, :species, :bounty_value, :danger_level, :last_known_location
  attr_reader :id

  def initialize( hunter_details )
    @name = hunter_details['name']
    @species = hunter_details['species']
    @bounty_value = hunter_details['bounty_value']
    @danger_level = hunter_details['danger_level']
    @last_known_location = hunter_details['last_known_location']
  end

  def BountyHunter.all()
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
      })
    sql = "SELECT * FROM bounty_hunters"
    db.prepare("all", sql)
    hunters = db.exec_prepared("all")
    db.close()
    return hunters.map{|hunter| BountyHunter.new(hunter)}
  end

  # CLASS METHOD = NO NEED for an instance to call this method.
  # no need to call .new()
  def BountyHunter.delete_all()
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
      })
    sql = "DELETE FROM bounty_hunters"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def BountyHunter.find(id)
    db = PG.connect({dbname: 'space_cowboys', host: 'localhost'})
    sql = "SELECT * FROM bounty_hunters WHERE id = $1"
    values = [id]
    db.prepare("find", sql)
    result_array = db.exec_prepared("find", values)
    return nil if !results_array.first
    bounty_hash = results_array[0]
    bounty = Bounty.new(bounty_hash)
    return bounty
  end

  def BountyHunter.find_by_name(name)
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
      })
    sql = "SELECT * FROM bounty_hunters WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    results = db.exec_prepared("find_by_name", values)
    found_hash = results[0]
    return BountyHunter.new(found_hash)
  end

  def save()
    db = PG.connect({
      dbname: 'space_cowboys',
      # table name: 'bounty_hunters';
      host: 'localhost'
      })
    sql = 'INSERT INTO bounty_hunters(name, species, bounty_value, danger_level, last_known_location) VALUES ($1, $2, $3, $4, $5) RETURNING *'
    values = [@name, @species, @bounty_value, @danger_level, @last_known_location]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def delete()
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
      })
      sql = 'DELETE FROM bounty_hunters WHERE id = $1'
      values = [@id]
      db.prepare('delete', sql)
      db.exec_prepared('delete', values)
      db.close()
  end

  def update()
    db = PG.connect({
      dbname: 'space_cowboys',
      host: 'localhost'
      })
    sql = 'UPDATE bounty_hunters SET (name, species, bounty_value, danger_level, last_known_location) = ($1, $2, $3, $4, $5) WHERE ID = $6'
    values = [@name, @species, @bounty_value, @danger_level, @last_known_location, @id]
    db.prepare('update', sql)
    db.exec_prepared('update', values)
    db.close()
  end

end
