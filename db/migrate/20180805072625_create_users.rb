class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password
      t.index :name, unique: true

      t.timestamps
    end
  end
end
