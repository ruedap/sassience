class CreateSheets < ActiveRecord::Migration
  def change
    create_table :sheets do |t|
      t.text :original_code
      t.text :converted_code
      t.integer :converted_type

      t.timestamps
    end
  end
end
