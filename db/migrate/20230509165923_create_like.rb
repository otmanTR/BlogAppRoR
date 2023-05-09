class CreateLike < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.references :user_id, null: false, foreign_key: { to_table: :users }, index: true
      t.references :post, null: false, foreign_key: true, index: true

      t.timestamps
    end
  end
end
