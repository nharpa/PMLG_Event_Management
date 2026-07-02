class CreateAnnouncements < ActiveRecord::Migration[8.1]
  def change
    create_table :announcements do |t|
      t.references :event,  null: false, foreign_key: true
      t.string     :title,  null: false
      t.text       :body,   null: false
      t.boolean    :pinned, null: false, default: false
      t.datetime   :published_at
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :announcements, :published_at
    add_index :announcements, :pinned
  end
end
