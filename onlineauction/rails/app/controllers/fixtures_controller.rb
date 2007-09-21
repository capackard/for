if RAILS_ENV == "test"
  require 'active_record/fixtures'
  
  class FixturesController < ApplicationController
    RESULTS_FILE = File.join(RAILS_ROOT, '..', 'flex', 'bin', 'test_results.txt')
    
    def create
      table_names = params[:fixtures][:fixture]
      Fixtures.create_fixtures("#{RAILS_ROOT}/test/fixtures/", table_names, {})
      render :xml => "<status>ok</status>" 
    end
    
    def crossdomain
      render :text => <<-EOXML
<?xml version="1.0"?>
<!DOCTYPE cross-domain-policy SYSTEM "http://www.macromedia.com/xml/dtds/cross-domain-policy.dtd">
<cross-domain-policy>
   <allow-access-from domain="*" />
</cross-domain-policy>
      EOXML
    end
    
    def test_results
      RAILS_DEFAULT_LOGGER.debug "@@@WRITING to :#{RESULTS_FILE}"
      File.open(RESULTS_FILE, 'w') { |f| f.write params[:results][:data] }
      head :ok
    end
  end
  
end #if test