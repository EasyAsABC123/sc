#
# Author:: Justin Schuhmann
# Cookbook Name:: sc
# Provider:: windows

actions :create, :delete, :stop, :start, :restart
default_action :create

attribute :service_name, :kind_of => String, :name_attribute => true
attribute :path, :kind_of => String
attribute :description, :kind_of => String
attribute :start_arguments, :kind_of => String

attr_accessor :exists