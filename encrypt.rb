class Encrypt
  require 'prime'

  def initialize(file_path)
    if File.exist?(file_path)
      @file = File.open(file_path, "r:Utf-8")
      @open_key = generate_key
      encrypt_message
      enc_file = File.new("#{ Dir.pwd}/enc_file.txt", "w")
      enc_file.write(@enc_message.join("\n"))
      key_file = File.new("#{ Dir.pwd}/close_key.txt", "w")
      key_file.write(@close_key.join("\n"))
      @file.close
      enc_file.close
      key_file.close
    else
      puts "Файл не найден"
    end
  end

  private

  def generate_key
    list_easy = Prime.take_while { |p| p < rand(100..1000) }

    i = rand(list_easy.length - 5)
    j = rand(i + 1..list_easy.length - 1)

    p = list_easy[i]
    q = list_easy[j]
    n = p * q
    phi = (p - 1) * (q - 1)

    e = 2
    while e < n
      if gcd(e, phi) == 1
        break
      end
      e += 1
    end

    puts "Значение функции Эйлера #{phi} от #{n}"
    puts "Взаимно простое со значение функции Эйлера #{e}"

    d = 0
    k = 1
    while d == 0
      s = (k * phi + 1) % e
      if s == 0
        d = (k * phi + 1) / e
        break
      end
      k += 1
    end

    puts "Закрытый ключ шифрования (#{d},#{n})"
    @close_key = [d, n]
    [e, n]
  end

  def gcd(m, n)
    until (m == 0) || (n == 0)
      if m >= n
        m = m - n
      else
        n = n - m
      end
    end
    k = m == 0 ? n : m
  end

  def encrypt_message
    message = @file.read
    @enc_message = []
    message.each_char do |word|
      @enc_message.push((word.ord ** @open_key.first) % @open_key.last)
    end
  end
end
