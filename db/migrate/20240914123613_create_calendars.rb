class CreateCalendars < ActiveRecord::Migration[7.0]
  def change
    create_table :calendars do |t|
      t.references :user
      t.string :remote_id
      t.string :summary
      t.timestamps
    end
  end
end
