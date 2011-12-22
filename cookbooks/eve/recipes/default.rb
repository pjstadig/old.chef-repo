#
# Cookbook Name:: eve
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

cookbook_file "/etc/apt/apt.conf.d/00no-install-recommends" do
  mode 0644
  owner "root"
  group "root"
end

include_recipe "apt"
include_recipe "ubuntu"

# add the Canonical partner repo
template "/etc/apt/sources.list.d/canonical-partner.list" do
  mode 0644
  variables :code_name => node[:lsb][:codename]
  notifies :run, resources(:execute => "apt-get update"), :immediately
end

# Setup wireless
%w{wireless-tools bcmwl-kernel-source}.each do |p|
  package p
end

cookbook_file "/etc/modprobe.d/blacklist-bcma.conf" do
  mode 0644
  owner "root"
  group "root"
end

cookbook_file "/etc/wpa_supplicant/wpa_supplicant.conf" do
  mode 0600
  owner "root"
  group "root"
end

cookbook_file "/etc/network/interfaces" do
  mode 0600
  owner "root"
  group "root"
end
