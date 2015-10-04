class RemoveEmailToUser < ActiveRecord::Migration
  def change
    remove_column :users, :e_mail, :string
  end
end
