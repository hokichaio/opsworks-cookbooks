#change log output format
nginx_dir = "/etc/nginx"
cookbook_file "#{nginx_dir}/conf.d/logformat.conf" do
  source "logformat.conf"
  mode 0644
  owner 'root'
  group 'root'
end

#change nginx log dir to mnt
log_dir = "/var/log/nginx"
log_mnt_dir = "/mnt/var/log/nginx"
default_user = node[:nginx_config][:user]
default_group = node[:nginx_config][:group]
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

cache_dir = "/mnt/var/cache"
cache_nginx_dir = "/mnt/var/cache/nginx"
#create cache dir in mnt
directory cache_dir do
  action :create
  owner 'root'
  group 'root'
  recursive true
end
directory cache_nginx_dir do
  action :create
  owner default_user
  group default_group
  recursive true
end
