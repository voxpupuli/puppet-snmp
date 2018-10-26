# Checks if a certain program/daemon is running and with which
# arguments it has been launched.
RSpec.shared_examples 'has_process' do |manifest, program, arguments|
	context 'process is running' do
		let(:process) { shell("/bin/ps -C #{program} -o comm=", accept_all_exit_codes: true).stdout.strip }
		subject { process }
		it "should be running #{program}" do
      puts "process only check: '#{process}'"
			is_expected.to eql(program)
		end
	end
	unless arguments.nil? or arguments.size == 0
		context 'process is running with arguments' do
			let(:process) { shell("/bin/ps -C #{program} -o cmd=", accept_all_exit_codes: true).stdout.strip }
			let(:args) do
        process.split(' ')[1..-1]
      end
			subject { args }
		  it "should be running #{program} with arguments #{arguments.inspect}" do
        puts "process with args check: '#{process.inspect}' / #{args.inspect}"
        is_expected.not_to be_empty
		    arguments.each do |sample|
          is_expected.to include(sample)
        end
			end
		end
	end
end
