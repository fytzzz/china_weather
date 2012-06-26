class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.integer :num  #地区编号
      t.string :name  #地区密码
      t.integer :parent_id
      t.integer :seqnum  #排序

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
