nginx_dir = "/etc/nginx"
node[:deploy].each do |k, v|
  app_name = k.to_s
  
  cookbook_file "#{nginx_dir}/sites-available/#{app_name}" do
    source app_name
    mode 0644
    owner 'root'
    group 'root'
    ignore_failure true
  end
  
end
service "nginx" do
  action :reload
end