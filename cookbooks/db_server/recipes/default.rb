#
# Cookbook Name:: db_server
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# remove conflict mysql packages
package 'mysql-libs' do
  action :remove
end

# re-install crontabs
package 'crontabs' do
  action :install
end

['MySQL-server', 'MySQL-client', 'MySQL-devel', 'MySQL-shared', 'MySQL-shared-compat'].each do |pkg|
  package pkg do
    version '5.5.17-1.linux2.6'
    action :install
  end
end

service 'mysql' do
  action  [ :enable, :start ]
end
