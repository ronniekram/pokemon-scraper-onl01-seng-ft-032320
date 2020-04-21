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
  
  def self.save(name, type,db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
    
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  def self.find(id_num, db)
    id_find = db.execute("SELECT * FROM pokemon WHERE id=?", id_num).first
    Pokemon.new(id: id_find[0], name: id_find[1], type: id_find[2], db: db)
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
