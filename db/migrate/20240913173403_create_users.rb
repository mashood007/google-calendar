class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, unique: true
      t.string :google_uid, unique: true
      t.string :google_access_token
      t.string :google_refresh_token
      t.datetime :token_expires_at

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :google_uid, unique: true
  end
end
