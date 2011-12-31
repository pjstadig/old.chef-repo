#
# Cookbook Name:: sonian
# Recipe:: default
#
# Copyright 2011, Paul Stadig
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
include_recipe "keyboard"
include_recipe "basic"
include_recipe "openjdk"
include_recipe "rabbitmq"

package "libshadow-ruby1.8"
package "curl"
package "mysql-server"
package "socat"
package "p7zip-full"
package "unzip"
package "readpst"
package "rar"

user "vagrant" do
  action :lock
end

directory "/home/vagrant/.ssh" do
  owner "vagrant"
  group "vagrant"
  mode "0755"
end

cookbook_file "/home/vagrant/.ssh/authorized_keys" do
  owner "vagrant"
  group "vagrant"
  mode "0644"
end

["/home/vagrant/src", "/home/vagrant/src/sonian"].each do |d|
  directory d do
    owner "vagrant"
    group "vagrant"
    mode "0755"
  end
end

es_version = node[:sonian][:elasticsearch][:version]
execute "expand-elasticsearch" do
  command "tar xzf elasticsearch-#{es_version}.tar.gz" +
    " && ln -sf elasticsearch-#{es_version} elasticsearch" +
    " && rm elasticsearch-#{es_version}.tar.gz"
  cwd "/home/vagrant/src/sonian"
  user "vagrant"
  action :nothing
end

remote_file "/home/vagrant/src/sonian/elasticsearch-#{es_version}.tar.gz" do
  source "https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-#{es_version}.tar.gz"
  owner "vagrant"
  group "vagrant"
  mode "0600"
  notifies :run, resources(:execute => "expand-elasticsearch"), :immediately
  not_if { File.exists?("/home/vagrant/src/sonian/elasticsearch-#{es_version}") }
end
