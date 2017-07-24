class CreateSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :steps do |t|
      t.integer :post_id
      t.string :content
      t.string :name
      t.timestamps
    end
  end
end
