#
# Cookbook Name:: rundeck-server
# Recipe:: default
#
# Copyright (C) 2013 Ben Buckley
#
case node[:platform_family]
when "debian"
  include_recipe "apt"

  package "openjdk-6-jre-headless" do
  	action	:install
  end

  remote_file "#{Chef::Config[:file_cache_path]}/rundeck-#{node[:rundeck][:version]}.deb" do
	not_if "dpkg -s rundeck | grep Status"
	source node[:rundeck][:download_url]
	action :create_if_missing
  end

  dpkg_package "rundeck-#{node[:rundeck][:version]}.deb" do
	not_if "dpkg -s rundeck | grep Status"
	source "#{Chef::Config[:file_cache_path]}/rundeck-#{node[:rundeck][:version]}.deb"
	action :install
  end

  service "rundeckd" do
 	action :start
  end
else
	Chef::Log.error "no platform support."
end
