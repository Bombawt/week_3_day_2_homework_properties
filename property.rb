require('pg')

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :year_built
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value']
    @number_of_bedrooms = options['number_of_bedrooms']
    @year_built = options['year_built']
    @id = options['id'].to_i if options['id']
  end

  def save()
    db = PG.connect({dbname: 'properties', host:'localhost'})
    sql =
    "INSERT INTO properties
      (address,
       value,
       number_of_bedrooms,
       year_built
      )
      VALUES
      (
        $1,
        $2,
        $3,
        $4
      )
      RETURNING *
      "
      values = [@address, @value, @number_of_bedrooms, @year_built]

      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]["id"].to_i
      db.close
  end

  def Property.all()
    db = PG.connect({dbname: 'properties', host:'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    db.exec_prepared("all")
    db.close
    return properties.map{|property| Property.new(property)}
  end

  def update()
    db = PG.connect({dbname: 'properties', host:'localhost'})
    sql = "UPDATE properties
    SET
    (
      address,
      value,
      number_of_bedrooms,
      year_built
    ) =
    (
      $1, $2, $3, $4
    )
    WHERE id = $5"
    values = [@address, @value, @number_of_bedrooms, @year_built, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close
  end

  def delete()
    db = PG.connect({dbname: 'properties', host:'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end







end
