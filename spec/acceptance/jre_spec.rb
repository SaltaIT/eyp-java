require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'openvas class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      java::jre { '8':
        jre_url => 'https://s3-eu-west-1.amazonaws.com/nms.jre.repository/jre-8u131-linux-x64.tar.gz',
      }

      java::jre { '7':
        jre_url => 'https://s3-eu-west-1.amazonaws.com/nms.jre.repository/jre-7u80-linux-x64.tar.gz',
        set_as_default_java => true,
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    it "check default java is 1.7" do
      expect(shell("java -version 2>&1 | grep -E '\\b1.7.'").exit_code).to be_zero
    end

    it "check SUN default java is 1.7" do
      expect(shell("java -version 2>&1 | grep -E 'Java HotSpot(TM)'").exit_code).to be_zero
    end

    it "check java is 1.8" do
      expect(shell("/opt/jre-8/bin/java -version 2>&1 | grep -E '\\b1.8.'").exit_code).to be_zero
    end

    it "check SUN java is 1.8" do
      expect(shell("/opt/jre-8/bin/java -version 2>&1 | grep -E 'Java HotSpot(TM)'").exit_code).to be_zero
    end

    it "double check java 1.7 installation" do
      expect(shell("/opt/jre-7/bin/java -version 2>&1 | grep -E '\\b1.7.'").exit_code).to be_zero
    end

    it "double check SUN java 1.7 installation" do
      expect(shell("/opt/jre-7/bin/java -version 2>&1 | grep -E 'Java HotSpot(TM)'").exit_code).to be_zero
    end

  end
end
