class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.references :list, null: false, foreign_key: true
      t.boolean :completed
      t.datetime :completed_at
      t.string :name

      t.timestamps
    end
  end
end
