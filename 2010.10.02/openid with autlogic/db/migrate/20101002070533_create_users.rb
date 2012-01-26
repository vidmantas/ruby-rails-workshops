class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
	t.string    :login,               :null => true
    	t.string    :email,               :null => true
    	t.string    :crypted_password,    :null => true
    	t.string    :password_salt,       :null => true
    	t.string    :persistence_token,   :null => false
    	t.string    :single_access_token, :null => false
    	t.string    :perishable_token,    :null => false 

    	t.integer   :login_count,         :null => false, :default => 0
    	t.integer   :failed_login_count,  :null => false, :default => 0
    	t.datetime  :last_request_at
    	t.datetime  :current_login_at
    	t.datetime  :last_login_at
    	t.string    :current_login_ip
    	t.string    :last_login_ip
	t.string    :openid_identifier, :null => true
      	t.timestamps
    end

    add_index :users, :openid_identifier
  end

  def self.down
    drop_table :users
  end
end
