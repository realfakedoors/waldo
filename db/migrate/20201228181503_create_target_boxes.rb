class CreateTargetBoxes < ActiveRecord::Migration[5.2]
  def change
    create_table :target_boxes do |t|
      t.integer :top
      t.integer :bottom
      t.integer :left
      t.integer :right
      t.belongs_to :subject, foreign_key: true

      t.timestamps
    end
  end
end
