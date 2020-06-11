wkhtmltopdf =
  if File.exist?('/usr/bin/wkhtmltopdf')
    '/usr/bin/wkhtmltopdf'
  else
    Gem.bin_path 'wkhtmltopdf-binary', 'wkhtmltopdf'
  end

WickedPdf.config = {
  exe_path: wkhtmltopdf
}
