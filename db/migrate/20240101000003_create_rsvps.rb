class CreateRsvps < ActiveRecord::Migration[8.1]
  def change
    create_table :rsvps do |t|
      t.references :user,  null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.integer    :status, null: false, default: 0

      t.timestamps
    end

    add_index :rsvps, [:user_id, :event_id], unique: true
  end
end
