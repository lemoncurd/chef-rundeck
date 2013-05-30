#
# Cookbook Name:: rundeck-server
# Recipe:: default
#
# Copyright 2013, Ben Buckley
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
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
