require('pg')

class Bounty

  attr_accessor :name, :species, :bounty_value, :favourite_weapon
  attr_reader :id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @species = options['species']
    @bounty_value = options['bounty_value'].to_i
    @favourite_weapon = options['favourite_weapon']
  end

  def save()
      db = PG.connect( { dbname: 'bounty_hunter', host: 'localhost' })
      sql =
        "INSERT INTO bounties
          ( name,
            species,
            bounty_value,
            favourite_weapon)
          VALUES
          ($1, $2, $3, $4)
          RETURNING *
          "
      values = [@name, @species, @bounty_value, @favourite_weapon]
      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]['id'].to_i
      db.close()
    end

    def self.delete_all()
      db = PG.connect( {dbname: 'bounty_hunter', host: 'localhost' })
      sql = "DELETE FROM bounties"
      db.prepare("delete_all", sql)
      db.exec_prepared("delete_all")
      db.close()
    end

    def delete()
    db = PG.connect( {dbname: 'bounty_hunter', host: 'localhost' })
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def update()
    db = PG.connect( {dbname: 'bounty_hunter', host: 'localhost' })
    sql = "UPDATE bounties
      SET (name, species, bounty_value, favourite_weapon) = ($1, $2, $3, $4)
      WHERE id = $5"

      values = [@name, @species, @bounty_value, @favourite_weapon, @id]
      db.prepare("update", sql)
      db.exec_prepared("update", values)
      db.close()
  end

  def self.all() #CLASS METHOD
    db = PG.connect( {dbname: 'bounty_hunter', host: 'localhost' })
    sql = "SELECT * FROM bounties"
    db.prepare("all", sql)
    bounty_list = db.exec_prepared("all")
    db.close()
    result = []
    for bounty in bounty_list
      result.push(Bounty.new(bounty))
    end
    return result
    # return bounty_list.map {|bounty| Bounty.new(bounty)}
  end

  def self.find(id)
    db = PG.connect( {dbname: 'bounty_hunter', host: 'localhost' })
    sql = "SELECT * FROM bounties WHERE id = $1"
    db.prepare("find", sql)
    values = [id]
    result = db.exec_prepared("find", values)
    db.close()
    return result.map {|bounty| Bounty.new(bounty)}[0]
  end


end
