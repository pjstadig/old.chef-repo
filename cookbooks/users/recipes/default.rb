#
# Cookbook Name:: users
# Recipe:: default
#
# Copyright 2011, Paul Stadig.
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

package "libshadow-ruby1.8"

search(:users, '*:*') do |u|
  if node[:apache] and node[:apache][:allowed_openids]
    Array(u['openid']).compact.each do |oid|
      node[:apache][:allowed_openids] << oid unless node[:apache][:allowed_openids].include?(oid)
    end
  end

  home_dir = "/home/#{u['id']}"

  # fixes CHEF-1699
  ruby_block "reset group list" do
    block do
      Etc.endgrent
    end
    action :nothing
  end

  user u['id'] do
    uid u['uid']
    gid u['gid']
    shell u['shell']
    comment u['comment']
    supports :manage_home => true
    home home_dir
    password u['password']
    notifies :create, "ruby_block[reset group list]", :immediately
  end

  directory "#{home_dir}/.ssh" do
    owner u['id']
    group u['gid'] || u['id']
    mode "0700"
  end

  template "#{home_dir}/.ssh/authorized_keys" do
    source "authorized_keys.erb"
    owner u['id']
    group u['gid'] || u['id']
    mode "0600"
    variables :ssh_keys => u['ssh_keys']
  end

  u['groups'].each do |g|
    if g != "sysdamin"
      group g do
        members u['id']
        append true
      end
    end
  end
end
