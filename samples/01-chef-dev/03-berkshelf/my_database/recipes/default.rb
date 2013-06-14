#
# Cookbook Name:: my_database
# Recipe:: default
#
# Copyright (C) 2013 CeSPI - UNLP
# 
# All rights reserved - Do Not Redistribute
#

db_super_connection = {:host => "localhost", :username => 'root', :password => node['mysql']['server_root_password']}

mysql_database node[:my_database][:name] do
  connection db_super_connection
  action :create
end

mysql_database_user node[:my_database][:user] do
  connection db_super_connection
  database_name node[:my_database][:name]
  password node[:my_database][:password]
  action [:create, :grant]
end

