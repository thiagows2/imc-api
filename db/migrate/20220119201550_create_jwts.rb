class CreateJwts < ActiveRecord::Migration[5.2]
  def change
    create_table :jwts do |t|
      t.string :access_token

      t.timestamps
    end
  end
end
