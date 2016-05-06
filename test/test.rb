require 'test/unit'
require 'dust'
$:.unshift(File.join(File.dirname(__FILE__),'/../lib'))
require 'scythe'
include Scythe

def create_test_instances(count, tags)
  data={}
  (1..count).each do |i|
    data[i] = Fog::Compute[:aws].servers.create(
        {
          :image_name => "ami-840910ee",
          :machine_type => "n1-standard-1",
          :zone_name => "us-east1-a",
          :tags => tags,
        }
    )
  end
  # wait for the last one
  data[data.keys.length].wait_for { ready? }
end

TEST_SERVERS = create_test_instances(1, {'basho-builds'=>'true'})

functional_tests do

  test "can get list of servers" do

    servers = get_servers_for_termination(60000, 'basho-builds')
    assert_equal [], servers
    servers = get_servers_for_termination(5, nil)
    assert_equal [], servers
    servers = get_servers_for_termination(5, 'nonexistant-tag')
    assert_equal [], servers
    servers = get_servers_for_termination(5, 'basho-builds' )
    assert servers.length > 0
    server = servers.first
    assert server.tags.key?('basho-builds')
    assert server.created_at.strftime("%s")

    servers.each do |server|
      terminate_server_by_id(server.id, 'basho-builds')
    end
  end

end
