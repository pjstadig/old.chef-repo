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

package "libshadow-ruby1.8"
package "curl"

user "sonian" do
  uid 7000
  supports :manage_home => true
  home "/home/sonian"
  shell "/bin/bash"
  password "$1$alefTPi5$fXh04z3ikLmRYf2Ms.3y50"
end

directory "/home/sonian/.ssh" do
  owner "sonian"
  group "sonian"
  mode "0755"
end

cookbook_file "/home/sonian/.ssh/authorized_keys" do
  owner "sonian"
  group "sonian"
  mode "0644"
end

["/home/sonian/src", "/home/sonian/src/sonian"].each do |d|
  directory d do
    owner "sonian"
    group "sonian"
    mode "0755"
  end
end

es_version = node[:sonian][:elasticsearch][:version]
execute "expand-elasticsearch" do
  command "tar xzf elasticsearch-#{es_version}.tar.gz" +
    " && ln -sf elasticsearch-#{es_version} elasticsearch" +
    " && rm elasticsearch-#{es_version}.tar.gz"
  cwd "/home/sonian/src/sonian"
  user "sonian"
  action :nothing
end

remote_file "/home/sonian/src/sonian/elasticsearch-#{es_version}.tar.gz" do
  source "https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-#{es_version}.tar.gz"
  owner "sonian"
  group "sonian"
  mode "0600"
  notifies :run, resources(:execute => "expand-elasticsearch"), :immediately
  not_if { File.exists?("/home/sonian/src/sonian/elasticsearch-#{es_version}") }
end
