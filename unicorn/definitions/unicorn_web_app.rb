define :unicorn_web_app do
  deploy = params[:deploy]
  application = params[:application]
  template_name = "nginx_unicorn_web_app.erb" 

  node[:deploy].each do |k, v|
    app_name = k.to_s
    if app_name == "adsyst"
      template_name = "adsyst.erb"
    end
  end

  nginx_web_app deploy[:application] do
    docroot deploy[:absolute_document_root]
    server_name deploy[:domains].first
    server_aliases deploy[:domains][1, deploy[:domains].size] unless deploy[:domains][1, deploy[:domains].size].empty?
    rails_env deploy[:rails_env]
    mounted_at deploy[:mounted_at]
    ssl_certificate_ca deploy[:ssl_certificate_ca]
    cookbook "unicorn"
    deploy deploy
    template template_name
    application deploy
  end
end
