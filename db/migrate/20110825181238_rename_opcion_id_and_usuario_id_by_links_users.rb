class RenameOpcionIdAndUsuarioIdByLinksUsers < ActiveRecord::Migration
  def self.up
    change_table :links_users do |t|
      t.rename :opcion_id, :link_id
      t.rename :usuario_id, :user_id
    end
  end

  def self.down
    change_table :links_users do |t|
      t.rename :link_id, :opcion_id
      t.rename :user_id, :usuario_id
    end
  end
end
