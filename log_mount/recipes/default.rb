node[:deploy].each do |depoy|
  if !File.symlink?(log_dir)
    log_dir = "#{depoy[:deploy_to]}/shared/log"
    log_mnt_dir = "/mnt/var/log/#{depoy[:application]}"
    default_user = node[:deploy][:deploy_user][:user]
    default_group = node[:deploy][:deploy_user][:group]
    directory log_dir do
      action :delete
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
  end
end
