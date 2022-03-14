require_relative 'encrypt'
require_relative 'decrypt'

while true
  puts "Do you want 1.Encrypt file 2.Decrypt file"
  num = gets.chomp.to_i
  if num == 0
    puts "Retry choose"
  else
    case num
    when 1
      puts "Message's file name"
      file_path = gets.chomp
      Encrypt.new(file_path)
      break
    when 2
      puts "Message's file name"
      file_path = gets.chomp
      puts "Key's file name"
      key_path = gets.chomp.to_s
      Decrypt.new(file_path, key_path)
      break
    else
      "You gave me #{num} -- I have no idea what to do with that."
    end
  end
end
