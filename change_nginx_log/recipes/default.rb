log_dir = "/var/log/nginx"
log_mnt_dir = "/mnt/var/log/nginx"
default_user = node[:change_nginx_log][:user]
default_group = node[:change_nginx_log][:group]
if !File.symlink?(log_dir)
  log "creating link for nginx log"
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
  service "nginx" do
    action :reload
  end
end
