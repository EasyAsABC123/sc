#
# Author:: Justin Schuhmann
# Cookbook Name:: sc
# Provider:: windows

require 'chef/mixin/shell_out'

include Chef::Mixin::ShellOut
include Windows::Helper

# Support whyrun
def whyrun_supported?
  true
end

action :add do
  unless @current_resource.exists
    CreateService()
  else
    Chef::Log.debug("#{@new_resource} service already exists - nothing to do")
  end
end

def load_current_resource
  @current_resource = Chef::Resource::ScWindows.new(@new_resource.name)
  @current_resource.share_name(@new_resource.service_name)
  @current_resource.path(@new_resource.path)
  @current_resource.description(@new_resource.description)
  cmd = "sc query \"#{@new_resource.service_name}\""
  
  Chef::Log.debug(cmd)
  if shell_out(cmd, {:returns => [0]})
    @current_resource.exists = true
  else
    @current_resource.exists = false
  end
end

private
  def CreateService
    cmd = "sc create \"#{@new_resource.service_name}\" binPath= \"#{@new_resource.path}\" start= auto"
    cmd << " DisplayName= \"#{@new_resource.description}\"" if @new_resource.description

    Chef::Log.debug(cmd)
    converge_by("Create #{ @new_resource } cmd #{cmd}") do
      shell_out!(cmd)
    end
    Chef::Log.info("Service Created")
  end
