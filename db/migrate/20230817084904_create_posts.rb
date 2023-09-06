class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ""
      t.text :body
      t.string :tags, array: true, default: []
      t.timestamp :published_at

      t.timestamps
    end
  end
end
