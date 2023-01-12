class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.text :body, null: false
      t.string :shopname, null: false
      t.timestamps
    end
  end
end
