class ApplicationController < ActionController::Base
  protect_from_forgery


# check that one or any of a series of records has expired, that is that the
# based on the creation date, any of the records are older than one hour
# if so, delete those records and return true indicating that records where deleted

  private

  def expired_check(recs)

    del = false
    recs.each do |r|
      created_at = r.created_at
      expire = created_at + 3600

      if Time.now > expire
        del = true
        r.destroy
      end
    end
    return del

  end

  # determine layout based on whether access is via web browser or cell phone browser

  def determine_layout
    layout = 'main'
    @web_browser = true
    if (mobile_browser)
      layout = 'main_mobile'
      @web_browser = false
      headers['Content-Type'] = 'text/vnd.wap.wml; charset=iso-8859-1'
    end
    return layout
  end

  # return true if browser appears to be from a cell phone.
  # this may not work from firefox on linux
  def mobile_browser
    mobile = false
    firefox = false
    ie = false;
    #puts request.env['HTTP_USER_AGENT']
    #if mat = /\s*Mozilla\/\d+\.\d+\s*\(Windows.*\s*Firefox/.match(request.env['HTTP_USER_AGENT'])
    if mat = /\s*Mozilla\/\d+\.\d+\s*.*\s*Firefox\/\d/.match(request.env['HTTP_USER_AGENT'])
      firefox = true
      # puts "FIREFOX \n"
    end
    if mat = /\s*Mozilla\/\d+\.\d+\s*\(.*MSIE.*Windows/.match(request.env['HTTP_USER_AGENT'])
      ie = true
      # puts "IE \n"
    end

    if (!ie && !firefox)
      logger.info('CELL ACCESS')
    else
      logger.info('BROWSER ACCESS')
    end
# use ?wml=1 in url to test on valaidation sites etc
    if ((!ie && !firefox) || params[:wml])
      mobile = true
    end
    return mobile
  end


end
