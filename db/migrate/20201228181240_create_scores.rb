class CreateScores < ActiveRecord::Migration[5.2]
  def change
    create_table :scores do |t|
      t.string :time
      t.string :initials

      t.timestamps
    end
  end
end
