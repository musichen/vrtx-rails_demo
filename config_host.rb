lines = IO.readlines(ARGV[0])

# The following command would recognize if we are running under AWS

my_host = `curl -m 1  http://169.254.169.254/latest/meta-data/local-ipv4`

unless my_host == ""

	lines.collect{|l|
		l.gsub!('<multicast enabled="true">', '<multicast enabled="false">' )
		l.gsub!('<aws enabled="false">', '<aws enabled="true">' )
		l.gsub!('<network>', '<network><public-address>' + my_host + '</public-address>' )
		l
	}

	File.open(ARGV[1], 'w') {|f|
		lines.each{|l|  f.puts l}
	}
	result = "-J-Dvertx.hazelcast.config=/tmp/aws-default-cluster.xml -J-Dvertx.cluster.public.host=" + my_host
	print result
else
	print '-J-Dvertx.hazelcast.config=/tmp/aws-default-cluster.xml -J-Ddummy_property=dummy_value'
end

