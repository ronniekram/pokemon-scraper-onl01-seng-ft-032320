class Pokemon
  attr_reader :id, :name, :type, :db
  
  @@all = []
  
  def initialize(id: nil, name:, type:, db:)
    @id = id 
    @name = name 
    @type = type 
    @db = db
    @@all << self
  end
  
  def self.save(name, type, db)
    @db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    
    @id = @db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  def self.find(id)
    sql = <<-SQL
      SELECT * 
      FROM pokemon 
      WHERE id = ?
      LIMIT 1
    SQL
    
    @db.execute(sql, id).map do |row|
      self.new_from_db(row)
    end.first 
  end
  
  def self.new_from_db(row)
    new_pokemon = self.new 
    new_pokemon.id = row[0]
    new_pokemon.name = row[1] 
    new_pokemon.type = row[2]
    new_pokemon.db = row[3]
    new_pokemon
  end
  
  
end
