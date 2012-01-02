#
# Cookbook Name:: skype
# Recipe:: default
#
# Copyright 2012, Paul Stadig
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

package "ia32-libs"
package "libxss1:i386"
package "libqt4-dbus:i386"
package "libqt4-gui:i386"

skype_deb = "skype-ubuntu_2.2.0.35-1_amd64.deb"
remote_file "/usr/src/#{skype_deb}" do
  source "http://download.skype.com/linux/#{skype_deb}"
  not_if { File.exists?("/usr/src/#{skype_deb}") }
end

dpkg_package "/usr/src/#{skype_deb}" do
  not_if "dpkg_query -s skype | grep ' installed'"
end
