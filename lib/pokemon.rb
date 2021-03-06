class Pokemon

  def initialize(attributes)
    attributes.each do |key, value|
      self.class.attr_accessor(key)
      self.send("#{key}=", value)
    end
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
  end

  def self.find(id, db)
    sql = "SELECT * FROM pokemon WHERE id = ?"
    result = db.execute(sql, id)[0]
    hash={}
    hash[:id]=result[0]
    hash[:name]=result[1]
    hash[:type]=result[2]
    Pokemon.new(hash)
  end
end
