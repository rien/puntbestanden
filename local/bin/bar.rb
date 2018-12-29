#!/bin/env ruby
require 'date'

def unread_mails
  `notmuch search tag:unread AND tag:inbox`.lines.count
end

def temperature
  temp = `sensors`.lines[2].gsub(/.*?\+(.*?)°C.*/, '\1').to_i
  "#{temp}℃"
end

def wifi
  link_info = `iw dev wlp58s0 link`
  if link_info.start_with?('Connected')
    " 📡 [#{link_info.lines[1].strip[6..-1]}]"
  else
    '⊥'
  end
end

def datetime
  DateTime.now.strftime('%a %d %b, %H:%M ')
end

def battery
  battery_info = `acpi -b`.strip
  percent = battery_info.gsub(/.*?(\d+%).*/, '\1')
  symbol = battery_info.include?('Discharging') ? '🔋' : '🔌'
  "#{symbol} #{percent}"
end

loop do
  bar = []
  mails = unread_mails
  if mails.positive?
    bar << "🖂 #{mails}"
  end
  bar << wifi << temperature << battery << datetime
  `xsetroot -name ' #{bar.join(' | ')}'`
  sleep 1
end
