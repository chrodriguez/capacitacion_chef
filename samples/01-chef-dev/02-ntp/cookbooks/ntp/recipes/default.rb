package 'ntp'

template '/etc/ntp.conf' do
  source    'ntp.conf.erb'
  notifies  :restart, 'service[ntp]'
end

service 'ntp' do
  action [:enable, :start]
end
