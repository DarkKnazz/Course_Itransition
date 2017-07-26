class AddColumnToSteps < ActiveRecord::Migration[5.0]
  def change
    add_column :steps, :text, :string
    add_column :steps, :image, :string
    add_column :steps, :video, :string
  end
end
