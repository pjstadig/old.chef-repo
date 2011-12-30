#
# Cookbook Name:: keyboard
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
execute "reconfigure-console-keyboard" do
  command "dpkg-reconfigure -f noninteractive -p high console-setup"
  action :nothing
end

if node[:platform_version] == "11.10"
  cookbook_file "/etc/default/keyboard" do
    mode 0644
    owner "root"
    group "root"
    notifies :run, resources(:execute => "reconfigure-console-keyboard"), :immediately
  end
else
  cookbook_file "/etc/default/console-setup" do
    mode 0644
    owner "root"
    group "root"
    notifies :run, resources(:execute => "reconfigure-console-keyboard"), :immediately
  end
end
