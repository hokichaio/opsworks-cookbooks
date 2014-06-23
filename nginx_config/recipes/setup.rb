nginx_dir = "/etc/nginx"
cookbook_file "#{nginx_dir}/conf.d/logformat.conf" do
  source "logformat.conf"
  mode 0644
  owner 'root'
  group 'root'
end