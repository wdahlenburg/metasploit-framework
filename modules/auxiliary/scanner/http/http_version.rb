##
# This module requires Metasploit: http//metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

require 'rex/proto/http'
require 'msf/core'


class Metasploit3 < Msf::Auxiliary

  # Exploit mixins should be called first
  include Msf::Exploit::Remote::HttpClient
  include Msf::Auxiliary::WmapScanServer
  # Scanner mixin should be near last
  include Msf::Auxiliary::Scanner

  def initialize
    super(
      'Name'        => 'HTTP Version Detection',
      'Description' => 'Display version information about each system.',
      'Author'      => 'hdm',
      'License'     => MSF_LICENSE
    )

    register_wmap_options({
        'OrderID' => 0,
        'Require' => {},
      })
  end

  # Fingerprint a single host
  def run_host(ip)
    begin
      fp = http_fingerprint
      print_status("#{ip}:#{rport} #{fp}") if fp
    rescue ::Timeout::Error, ::Errno::EPIPE
    end
  end

end
