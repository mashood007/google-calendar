class CreateWebhooks < ActiveRecord::Migration[7.0]
  def change
    create_table :webhooks do |t|
      t.references :user
      t.datetime :expiration_date
      t.string :resource_id
      t.string :channel_id
      t.timestamps
    end
  end
end
