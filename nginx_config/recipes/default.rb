node[:deploy].each do |k, v|
  app_name = node[:deploy][k]
  nginx_dir = "/etc/nginx"
  
  cookbook_file "#{nginx_dir}/sites-available/#{app_name}" do
    source site
    mode 0644
    owner 'root'
    group 'root'
    ignore_failure true
  end
  
end
service "nginx" do
  action :reload
end


