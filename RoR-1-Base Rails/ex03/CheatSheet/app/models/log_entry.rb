# Reads and writes the diary entries stored in entry_log.txt.
class LogEntry
  FILE_PATH = Rails.root.join('entry_log.txt').to_s
  SEPARATOR = ' : '.freeze

  def self.all
    return [] unless File.exist?(FILE_PATH)

    File.readlines(FILE_PATH).map(&:chomp).reverse
  end

  def self.create(text)
    clean_text = text.to_s.strip.gsub(/\s*\n\s*/, ' ')
    return if clean_text.empty?

    File.open(FILE_PATH, 'a') { |file| file.puts(format_line(clean_text)) }
  end

  def self.format_line(text)
    "#{Time.now.strftime('%d/%m/%Y %H:%M:%S')}#{SEPARATOR}#{text}"
  end

  private_class_method :format_line
end
