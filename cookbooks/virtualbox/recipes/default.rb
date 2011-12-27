#
# Cookbook Name:: virtualbox
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
apt_repository "virtualbox" do
  uri "http://download.virtualbox.org/virtualbox/debian"
  distribution node['lsb']['codename']
  components ["contrib"]
  key "http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc"
  action :add
end

package "dkms"
package "virtualbox-4.1"
