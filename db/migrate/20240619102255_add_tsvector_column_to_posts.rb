class AddTsvectorColumnToPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :posts, :tsv, :tsvector
    add_index :posts, :tsv, using: :gin

    reversible do |dir|
      dir.up do
        execute <<-SQL
          CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
          ON posts FOR EACH ROW EXECUTE FUNCTION
          tsvector_update_trigger(tsv, 'pg_catalog.english', title, body);
        SQL

        execute <<-SQL
          UPDATE posts SET tsv = to_tsvector('english', coalesce(title, '') || ' ' || coalesce(body, ''));
        SQL
      end

      dir.down do
        execute <<-SQL
          DROP TRIGGER tsvectorupdate ON posts
        SQL
      end
    end
  end
end
