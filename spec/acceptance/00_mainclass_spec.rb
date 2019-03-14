require 'spec_helper_acceptance'
require_relative './version.rb'

describe 'openvas class' do

  context 'basic setup' do
    # Using puppet_apply as a helper
    it 'should work with no errors' do
      pp = <<-EOF

      class { 'java': }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

    it "package java install" do
      expect(shell("java -version").exit_code).to be_zero
    end

    it 'should work with no errors' do
      pp = <<-EOF

      class { 'java':
        package_ensure => 'absent',
      }

      EOF

      # Run it twice and test for idempotency
      expect(apply_manifest(pp).exit_code).to_not eq(1)
      expect(apply_manifest(pp).exit_code).to eq(0)
    end

  end
end
