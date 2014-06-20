nginx_dir = "/etc/nginx"

node[:nginx_config][:sites].each do |site|
  cookbook_file "#{nginx_dir}/sites-available" do
    source site
    mode 0644
    owner 'root'
    group 'root'
  end
end

cookbook_file "#{nginx_dir}/conf.d" do
  source "logformat.conf"
  mode 0644
  owner 'root'
  group 'root'
end

service "nginx" do
  action :reload
end