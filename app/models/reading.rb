require 'hpricot'
require 'open-uri'

#hdr = %w{ WDIR WSPD GST WVHT DPD PRES PTDY ATMP WTMP SAL VIS CHILL MWD}


class Reading < ActiveRecord::Base
  belongs_to :station


  def parse(page)

    hdr = %w{ WDIR WSPD GST WVHT DPD PRES PTDY ATMP WTMP SAL VIS CHILL MWD}

    doc = Hpricot(open(page))  #{ |f| Hpricot(f) }

    tidx = 0

    doc.search("/html/body//table").each do |tab|
    #puts "== Found a table =="
      if (mat = /Conditions at \S+ as of.*\((.*)\)/.match(tab.inner_html))
 #     print "#{mat[1]}\n"
        self.timeof_conditions = mat[1]
      end
      readings = false
      fldName = "";
      if tidx == 4
        (tab/'td').each do |data|
          if readings
 #          puts data.inner_html
            setField(fldName, data.inner_html)
            readings = false
          end
          if mat = /^.*\(([A-Z]+)\)/.match(data.inner_html)
            if hdr.any? {|itm| itm == mat[1]}
              readings = true
  #           print "#{mat[1]}: "
              fldName = mat[1]
            end
          end
        end
      end
      tidx += 1
    end
  end

  def setField(fldName, val)
    case fldName
      when 'WDIR'
        if (mat = /(.*)\(.*\)/.match(val))
          self.wdir = mat[1]
        end
      when 'WSPD'
        self.wspd = val
  #  when 'GST'
 #     self.gst = val
      when  'WVHT'
        self.wvht = val
      when  'DPD'
        self.dpd = val
      when  'PRES'
        self.pres = val
   #when  'PTDY'
  #   self.ptdy = val
      when  'ATMP'
        self.atmp = val
      when  'WTMP'
        self.wtmp = val
      when  'MWD'
        self.mwd = val
    end

  end

end