class CreateImc < ActiveRecord::Migration[5.2]
  def change
    create_table :imcs do |t|
      t.decimal :height, null: false, default: 0
      t.decimal :weight, null: false, default: 0
      t.decimal :imc, null: false, default: 0
      t.string :classification
      t.string :obesity
    end
  end
end
