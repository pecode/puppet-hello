require 'rubygems'
require 'net/ldap'
#require 'pp'

module Puppet::Parser::Functions
  newfunction(:ldap, :type => :rvalue) do |args|
    ldap = Net::LDAP.new :host => 'gikos.net',
    :port => '636',
    :encryption => :simple_tls,
    :auth => {
      :method => :simple,
      :username => "cn=admin,dc=acme,dc=com",
      :password => "secret"
    }
    filter = Net::LDAP::Filter.eq('objectclass', 'groupOfNames') & Net::LDAP::Filter.eq('cn', "pe_admins")
    treebase = "dc=acme,dc=com"
    ldap.search( :base => treebase, :filter => filter )
  end
end
