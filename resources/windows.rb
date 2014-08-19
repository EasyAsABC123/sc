#
# Author:: Justin Schuhmann
# Cookbook Name:: sc
# Provider:: windows

actions :add
default_action :add

attribute :service_name, :kind_of => String, :name_attribute => true
attribute :path, :kind_of => String
attribute :description, :kind_of => String

attr_accessor :exists