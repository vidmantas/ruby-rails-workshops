# encoding: utf-8
require 'pp'
require 'win32ole'

ATTRS = %w(country source name address phone fax email www contact desc)

# --- init/close
def with_excel(fname, lname=nil)
  WIN32OLE.codepage = WIN32OLE::CP_UTF8
  begin
    $excel = WIN32OLE.connect 'Excel.Application'
    $book = $excel.ActiveWorkbook
    puts "Connected to active file..."
  rescue WIN32OLERuntimeError
    puts "Trying opening file..."
    filename = File.join(Dir.getwd, fname+'.xls')
    begin
      $excel = WIN32OLE.new 'Excel.Application'
      $book = $excel.Workbooks.Open(filename)
      $excel.Visible = 1
    rescue WIN32OLERuntimeError => e
      puts "Excel error!\n" + e.to_s
      exit
    end
  end
  lname ||= fname
  $log = File.open(lname+'.txt','w+')
  
  yield
  
  $log.close
  # $excel.Quit
end

with_excel('paletes') do
  load('data.rb')
  sheet = $book.Worksheets(1)
    
  sheet.Range("A1:J1").Value = [ATTRS]
    
  $y.each_with_index do |it,idx|
    row = it.values_at(*ATTRS)
    
    begin
      sheet.Range("A#{idx+2}:I#{idx+2}").Value = [row]
    rescue Exception
    end
  end
end
