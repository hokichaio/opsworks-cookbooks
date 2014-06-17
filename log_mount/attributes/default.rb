default[:deploy][application][:user] = node[:opsworks][:deploy_user][:user]
case node[:platform]
when 'debian','ubuntu'
  default[:opsworks][:deploy_user][:group] = 'www-data'
when 'centos','redhat','fedora','amazon'
  default[:opsworks][:deploy_user][:group] = node['opsworks']['rails_stack']['name'] == 'nginx_unicorn' ? 'nginx' : 'apache'
end