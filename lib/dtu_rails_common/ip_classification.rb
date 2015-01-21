require 'netaddr'

module DtuRailsCommon
  module IpClassification

    def ip_in? cluster_name
      classify_ip(request.remote_ip, ip_clusters).include? cluster_name
    end

    def ip_clusters
      Rails.logger.warn "No IP clusters in config." unless Rails.application.config.auth.try :[], :ip
      Rails.application.config.auth[:ip] || {}
    end

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
