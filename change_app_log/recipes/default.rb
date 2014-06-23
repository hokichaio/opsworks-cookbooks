node[:deploy].each do |application, deploy|
  log_dir = "#{node[:deploy][application][:deploy_to]}/shared/log"
  log_mnt_dir = "/mnt/var/log/#{node[:deploy][application][:application]}"
  default_user = node[:change_app_log][:user]
  default_group = node[:change_app_log][:group]
  if !File.symlink?(log_dir)
    log "creating link for #{node[:deploy][application][:application]}"
    directory log_dir do
      action :delete
      recursive true
    end
    directory log_mnt_dir do
      action :create
      owner default_user
      group default_group
      recursive true
    end
    link log_dir do
      to log_mnt_dir
      owner default_user
      group default_group
    end
    execute "restart Server" do
      command "#{node[:deploy][application][:deploy_to]}/shared/scripts/unicorn #{node[:change_app_log][:restart_command]}"
      action :run
      only_if do 
        File.exists?("#{node[:deploy][application][:deploy_to]}/current")
      end
    end
  end
end
