class Decrypt

  def initialize(file_path, key_path)
    if File.exist?(file_path) && File.exist?(key_path)

      @file = File.open(file_path, "r:Utf-8")
      @key_file = File.open(key_path, "r:Utf-8")
      @key = []
      @key_file.each_line do |line|
        @key.push(line.to_i)
      end

      decrypt_message
      dnc_file = File.new("#{ Dir.pwd}/dnc_file.txt", "w")
      dnc_file.write(@dc_message)
      @file.close
      @key_file.close
      dnc_file.close
    else
      puts "Файл не найден"
    end
  end

  private

  def decrypt_message
    @dc_message = ""
    @file.readlines.each do |line|
      @dc_message += ((line.to_i ** @key.first) % @key.last).chr
    end
  end
end
