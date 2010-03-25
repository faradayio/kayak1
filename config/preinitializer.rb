################################
# NOTE: ActiveSupport is not loaded at this point, so don't use tricks like:
# .map(&:chomp)
# .starts_with?("ey01")
################################

unless defined?(PRIVATE_HOSTNAME)

  require 'socket'
  PRIVATE_HOSTNAME = Socket.gethostname

  # http://coderrr.wordpress.com/2008/05/28/get-your-local-ip-address/
  begin
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily

    PRIVATE_IP_ADDRESS = UDPSocket.open do |s|
      begin
        s.connect '64.233.187.99', 1
        s.addr.last
      rescue Errno::ENETUNREACH
        ENV['IP']
      end
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end

  if File.readable?('/etc/universe')
    UNIVERSE = IO.readlines('/etc/universe').first.chomp.to_sym
  else
    UNIVERSE = :developer
  end

  load File.expand_path("#{RAILS_ROOT}/deploy/universes/#{UNIVERSE}.rb")
end