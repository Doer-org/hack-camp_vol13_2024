class CreateFormulas < ActiveRecord::Migration[7.0]
  def change
    create_table :formulas do |t|
      t.references :project, null: false, foreign_key: true
      t.string :file_name
      t.text :content

      t.timestamps
    end
  end
end
