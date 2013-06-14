#
# Cookbook Name:: my_databag
# Recipe:: default
#
# Copyright (C) 2013 CeSPI - UNLP
# 
# All rights reserved - Do Not Redistribute
#
admins = data_bag('admins')
admins.each do |login|
    admin = data_bag_item('admins', login)
    home = "/home/#{login}"

    user(login) do
        uid       admin['uid']
        gid       admin['gid']
        shell     admin['shell']
        comment   admin['comment']
        home      home
        supports  :manage_home => true
    end
end
