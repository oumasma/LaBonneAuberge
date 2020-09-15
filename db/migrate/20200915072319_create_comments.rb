class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :event, index:true
      t.belongs_to :villager, index:true

      t.timestamps
    end
  end
end
