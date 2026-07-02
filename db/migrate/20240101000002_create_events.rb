class CreateEvents < ActiveRecord::Migration[8.1]
  def change
    create_table :events do |t|
      t.string   :title,       null: false
      t.text     :description
      t.datetime :start_time,  null: false
      t.datetime :end_time,    null: false
      t.string   :location
      t.integer  :capacity
      t.integer  :status,      null: false, default: 0
      t.references :coordinator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :events, :status
    add_index :events, :start_time
  end
end
