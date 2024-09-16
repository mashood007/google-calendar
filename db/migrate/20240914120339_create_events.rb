class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :summary
      t.datetime :start_time
      t.datetime :end_time
      t.references :calendar
      t.string :remote_id
      t.timestamps
    end
  end
end
