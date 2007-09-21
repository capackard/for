require 'rake/clean'

namespace :flex do
  FLEX_ROOT = File.join(File.dirname(__FILE__), '..', '..', '..', 'flex')
  
  def to_swf(files)
    files.pathmap("public/%n.swf")
  end
  
  def to_mxml(files)
    files.pathmap("#{FLEX_ROOT}/src/%n.mxml")
  end
  
  MXML_FILES = FileList["#{FLEX_ROOT}/src/*.mxml"]
  SWF_FILES = to_swf(MXML_FILES)
  ALL_SOURCE_FILES = FileList.new("#{FLEX_ROOT}/src/**/*.*") { |list| list.exclude(/^flex\/bin\/.*/); list.exclude(/^.*\.sh$/) }
  CLOBBER.include(SWF_FILES)
  
  ToMxmlLambda = lambda { |fn| to_mxml(fn) }
  
  rule(%r{\.swf\Z} => ToMxmlLambda) do |task|
    mxmlc = ENV['FLEX_SDK_3_HOME'] ? File.join(ENV['FLEX_SDK_3_HOME'], 'bin', 'mxmlc') : 'mxmlc'
    sh %Q{#{mxmlc} -output #{task.name} -compiler.services="../flex/src/services-config.xml" -compiler.library-path+="#{FLEX_ROOT}/libs" -- #{task.source}} do |ok, res|
      unless ok
        raise "Could NOT compile #{task.source} with #{mxmlc}.\nMake sure the Flex SDK 3 bin directory is in your PATH or set FLEX_SDK_3_HOME"
      end
    end
    # cp task.name, task.name.pathmap("public/%f") unless task.name =~ /test/i
  end
  
  SWF_FILES.each do |swf|
    file swf => ALL_SOURCE_FILES
  end
  
  desc "Build SWF's"
  task :build => SWF_FILES
  
  RESULTS_FILE = File.join('..', 'flex', 'bin', 'test_results.txt')
  desc "Remove Flex test results"
  task :clean_test_results do
    rm_f RESULTS_FILE
  end
  
  desc "Run Flex Tests"
  task :test => [:build, :clean_test_results] do
    test_swf = '../flex/bin/FlexUnitTestRunner.swf'
    if File.file?(test_swf)
      run_test_server do
        puts "Running Flex tests"
        sh "open #{test_swf}"
        seconds_waited = 0
        until File.file?(RESULTS_FILE) || seconds_waited > 30 do
          seconds_waited += 1
          sleep 1
        end
        if File.file?(RESULTS_FILE)
          output = File.read(RESULTS_FILE)
          rm_f RESULTS_FILE
          puts output
          raise "Test failures" if output =~ /FAILURE/m
        else
          raise "No Flex test output file found at #{RESULTS_FILE}"
        end
      end
    else
      puts "No test swf to run: #{test_swf}"
    end
  end

  def run_test_server
    require 'net/http'
    if (Net::HTTP.get_response('0.0.0.0', '/', 3030) && false rescue true)
      begin
        test_server_pid = fork do
          ARGV.clear
          ARGV.concat [ '-e', 'test', '-p', '3030']
          require File.dirname(__FILE__) + '/../../config/boot'
          require 'commands/server'
        end
        seconds_waited = 0
        begin
          Net::HTTP.get_response('0.0.0.0', '/', 3030)
        rescue Errno::ECONNREFUSED
          raise "Unable to connect to test server" if seconds_waited > 5
          seconds_waited += 1
          sleep 1
          retry
        end
        yield
      ensure
        sh "kill #{test_server_pid}"
        Process.wait(test_server_pid)
      end
    else
      yield
    end
  end
end

desc 'Build and test Flex files'
task :flex => 'flex:test'
task :default => :flex