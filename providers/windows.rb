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

action :create do
  if !@current_resource.exists
    cmd = "sc create \"#{@new_resource.service_name}\" binPath= \"#{@new_resource.path}\" start= auto"
    cmd << " DisplayName= \"#{@new_resource.description}\"" if @new_resource.description

    Chef::Log.info(cmd)
    converge_by("Create #{ @new_resource } cmd #{cmd}") do
      shell_out!(cmd)
    end
    Chef::Log.info("Service Created")
  else
    Chef::Log.info("#{@new_resource} service already exists - nothing to do")
  end
end

action :delete do
  if @current_resource.exists
    stop_service
    cmd = "sc delete \"#{@new_resource.service_name}\""

    Chef::Log.info(cmd)
    converge_by("Delete #{ @new_resource } cmd #{cmd}") do
      shell_out!(cmd)
    end
    Chef::Log.info("Service Deleted")
  else
    Chef::Log.info("#{@new_resource} service doesn't exist - nothing to do")
  end
end

action :stop do
  if @current_resource.exists
    stop_service
  else
    Chef::Log.info("#{@new_resource} service doesn't exist - nothing to do")
  end
end

action :start do
  if @current_resource.exists
    start_service
  else
    Chef::Log.info("#{@new_resource} service doesn't exist - nothing to do")
  end
end

action :restart do
  if @current_resource.exists
    stop_service
    start_service
  else
    Chef::Log.info("#{@new_resource} service doesn't exist - nothing to do")
  end
end

def load_current_resource
  @current_resource = Chef::Resource::ScWindows.new(@new_resource.name)
  @current_resource.service_name(@new_resource.service_name)
  @current_resource.path(@new_resource.path)
  @current_resource.description(@new_resource.description)
  cmd = "sc query \"#{@new_resource.service_name}\""
  
  Chef::Log.info(cmd)
  if ((shell_out(cmd)).exitstatus == 0)
    @current_resource.exists = true
  else
    @current_resource.exists = false
  end
end

private
  def stop_service
    output = shell_out("sc query \"#{@new_resource.service_name}\" | find /i \"STATE\"")
    if(output.stdout !~ /1  STOPPED/)
      cmd = "sc stop \"#{@new_resource.service_name}\""

      Chef::Log.info(cmd)
      converge_by("Stop #{ @new_resource } cmd #{cmd}") do
        shell_out!(cmd)
      end
      Chef::Log.info("Service Stopped")
    else
      Chef::Log.info("Service already stopped, nothing to do")
    end
  end

  def start_service
    output = shell_out("sc query \"#{@new_resource.service_name}\" | find /i \"STATE\"")
    if(output.stdout !~ /4  RUNNING/)
      cmd = "sc start \"#{@new_resource.service_name}\" \"#{@new_resource.start_arguments}\""

      Chef::Log.info(cmd)
      converge_by("Start #{ @new_resource } cmd #{cmd}") do
        shell_out!(cmd)
      end
      Chef::Log.info("Service Started")
    else
      Chef::Log.info("Service already running, nothing to do")
    end
  end