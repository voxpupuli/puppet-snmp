require 'beaker-puppet'
require 'beaker-rspec'
require 'beaker/puppet_install_helper'
require 'beaker/module_install_helper'

Dir["./spec/acceptance/support/**/*.rb"].sort.each { |f| require f }

run_puppet_install_helper unless ENV['BEAKER_provision'] == 'no'
configure_type_defaults_on(hosts)
install_module_on(hosts)
install_module_dependencies_on(hosts)

RSpec.configure do |c|
  c.formatter = :documentation

  #hosts.each do |host|
  #  case fact('os.family')
  #  when 'Debian'
  #    # nothing
  #  when 'RedHat'
  #    # Soft dep on epel for Passenger
  #    #         install_package(host, 'epel-release')
  #    #         end
  #  end
  #end
end
