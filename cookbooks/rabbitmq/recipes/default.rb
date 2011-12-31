#
# Cookbook Name:: rabbitmq
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

package "erlang-nox"

deb_file = "rabbitmq-server_2.3.1-1_all.deb"
remote_file "/usr/src/#{deb_file}" do
  source "http://www.rabbitmq.com/releases/rabbitmq-server/v2.3.1/#{deb_file}"
  notifies :install, resources(:dpkg_package => "/usr/src/#{deb_file}"), :immediately
end

dpkg_package "/usr/src/#{deb_file}" do
  action :nothing
  only_if "dpkg-query -s rabbitmq-server | grep not-installed"
end
