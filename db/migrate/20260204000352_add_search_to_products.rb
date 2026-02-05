class AddSearchToProducts < ActiveRecord::Migration[8.0]
  def up
    add_column :products, :search_vector, :tsvector
    add_index :products, :search_vector, using: :gin

    execute <<-SQL
      CREATE FUNCTION products_search_trigger() RETURNS trigger AS $$
      begin
        new.search_vector :=
          setweight(to_tsvector('english', coalesce(new.name, '')), 'A') ||
          setweight(to_tsvector('english', coalesce(new.description, '')), 'B');
        return new;
      end
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER products_search_update BEFORE INSERT OR UPDATE
        ON products FOR EACH ROW EXECUTE FUNCTION products_search_trigger();
    SQL
  end

  def down
    execute <<-SQL
      DROP TRIGGER IF EXISTS products_search_update ON products;
      DROP FUNCTION IF EXISTS products_search_trigger();
    SQL

    remove_index :products, :search_vector
    remove_column :products, :search_vector
  end
end
