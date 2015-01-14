module DtuRailsCommon
  module Controllers
    module Helpers
      
      # Determine which of the given IP address clusters the given IP address belongs to.
      # ip_clusters is a hash mapping cluster names to IP address lists like
      #   { :walk_in => ['10.0.0.1/24', '10.1.1.5-10.1.1.10'] }.
      # Returns a list of the cluster names the IP address is contained in
      def classify_ip ip_string, ip_clusters
        matching_clusters = []
        ip = NetAddr::CIDR.create ip_string
        ip_clusters.each do |cluster_name, cluster_ips|
          matching_clusters << cluster_name if ips_include? cluster_ips, ip  
        end
        matching_clusters
      rescue => e
        Rails.logger.error "#{ip_string} is not an IP address. #{e.class}: #{e.message}"
        []
      end

      # Determine if a list of IP adresses (with ranges, wildcards, etc.) include
      # a given IP address
      def ips_include? ips, ip
        result = false
        ips.each do |current_ip|
          if current_ip.include? '-' 
            # Range
            lower, upper = NetAddr::CIDR.create($1), NetAddr::CIDR.create($2) if current_ip =~ /^(\S*)\s*-\s*(\S*)$/
            result ||= (lower..upper).include? ip
          elsif current_ip.include? '*' 
            # Wildcard
            result ||= NetAddr.wildcard(current_ip).matches? ip
          else
            # Standard
            result ||= NetAddr::CIDR.create(current_ip).matches? current_ip
          end
        end
        result
      end

    end
  end
end
