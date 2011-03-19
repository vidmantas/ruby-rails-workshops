#  Encrypts and decrypts an alleged RC4 hash.
#  @author Mika Palmu
#  @version 1.0
# 
#  Orginal Flash port by:
#  Gabor Penoff - http://www.fns.hu
#  Email: fns@fns.hu

class RC4

  # Variables
  # 
  def initialize
    @sbox  = [] # 255
    @mykey = [] # 255
  end
  
  # Encrypts a string with the specified key.
  # 
  def encrypt(src, key) # String, String -> String
    mtxt = strToChars(src)
    mkey = strToChars(key)
    result = calculate(mtxt, mkey)
    charsToHex(result)
  end
  
  # Decrypts a string with the specified key.
  # 
  def decrypt(src, key) # String, String -> String
    mtxt = hexToChars(src)
    mkey = strToChars(key)
    result = calculate(mtxt, mkey)
    charsToStr(result)
  end
  
  # Private methods.
  # 
  def init(pwd) # Array
    b = 0
    intLength = pwd.length
    (0..255).each do |a|
      @mykey[a] = pwd[ a % intLength ]
      @sbox[a] = a
    end
    (0..255).each do |a|
      b = (b+@sbox[a]+@mykey[a]) % 256
      @sbox[a], @sbox[b] = @sbox[b], @sbox[a]
    end
  end
  
  def calculate(plaintxt, psw) # Array, Array -> Array
    init(psw)
    i = 0; j = 0
    cipher = []
    plaintxt.each do |p|
      i = (i+1) % 256
      j = (j+@sbox[i]) % 256
      @sbox[i], @sbox[j] = @sbox[j], @sbox[i]
      idx = (@sbox[i]+@sbox[j]) % 256
      k = @sbox[idx]
      cipherby = p ^ k
      cipher << cipherby
    end
    cipher
  end
  
  # --- utility ---
  private

  def charsToHexO(chars) # Array -> String
    result = ''
    hexes = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"]
    chars.each do |c|
      result += hexes[c >> 4] + hexes[c & 0xf]
    end
    result
  end

  def charsToHex(chars) # Array -> String
    ('%02x' * chars.size) % chars
  end
  
  def hexToChars(str) # String -> Array
    codes = []
    str.slice! /^0x/
    (0..str.length-1).step(2) do |i|
      codes << str[i, 2].hex
    end
    codes
  end
  
  def charsToStr(chars) # Array -> String
    result = ''
    chars.each {|c| result += c.chr }
    result
  end
  
  def strToChars(str) # String -> Array
    codes = []
    str.each_byte {|c| codes << c }
    codes
  end
  
  # --- testing ---
  public
  
  def test_all
    p charsToStr([108, 97, 98, 97, 115])
    p strToChars('labas')
    p charsToHexO([108, 97, 98, 97, 115])
    p charsToHex([108, 97, 98, 97, 115])
    p hexToChars('0x6c61626173')
    p hexToChars('6c61626173')
    puts RC4.new.decrypt('4869d36ab0d48ce349b735d39f32fb578f10098bc1e08656be77d527cfcfed74456c5a4dcaf5f6f56b4d616bbcc1639ba7f8135d181ae324635cfc2c1611b3d66422770f178d','sdf883jsdf22')
  end

end

# -- testing --
# RC4.new.test_all
# puts RC4.new.decrypt('4869d36ab0d48ce349b735d39032fb578f10098bc1e08656be77d527cfcfed74456c5a4dcaf5f6f56b4d616bbcc16385e5bb14480f46ff73260fa37a174af0d6','sdf883jsdf22')