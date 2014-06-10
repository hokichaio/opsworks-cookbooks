package "nagios-nrpe-server"

##################
# plugin install
##################
plugin_dir = "/usr/lib/nagios/plugins"

cookbook_file "#{plugin_dir}/check_logfiles" do
  source "check_logfiles"
  mode 0755
  owner 'root'
  group 'root'
end

##################
# config setting
##################
conf_dir = "/etc/nagios"
plugin_conf_dir = "/etc/nagios-plugins/config"

# nrpe.cfg
cookbook_file "#{conf_dir}/nrpe.cfg" do
  source "nrpe.cfg"
  mode 0644
  owner 'root'
  group 'root'
end

# nrpe_local.cfg
cookbook_file "#{conf_dir}/nrpe_local.cfg" do
  source "nrpe_local.cfg"
  mode 0644
  owner 'root'
  group 'root'
end

# check_logfiles.cfg
cookbook_file "#{plugin_conf_dir}/check_logfiles.cfg" do
  source "check_logfiles.cfg"
  mode 0644
  owner 'root'
  group 'root'
end

##################
# restart nagios
##################
service "nagios-nrpe-server" do
  action :restart
end
