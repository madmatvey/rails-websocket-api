class CreateVisitors < ActiveRecord::Migration[6.1]
  def change
    create_table :visitors do |t|
      t.string :visitor_id, null: false, index: true, unique: true
      t.boolean :online, null: false, index: true, default: false 

      t.timestamps
    end
  end
end
