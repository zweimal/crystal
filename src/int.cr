struct Int
  def ==(other : Char)
    self == other.ord
  end

  def +
    self
  end

  def ~
    self ^ -1
  end

  def abs
    self >= 0 ? self : -self
  end

  def floor
    self
  end

  def ceil
    self
  end

  def round
    self
  end

  def **(other : Int)
    (to_f64 ** other).to_i
  end

  def **(other)
    to_f64 ** other
  end

  def bit(bit)
    self & (1 << bit) == 0 ? 0 : 1
  end

  def gcd(other : Int)
    self == 0 ? other.abs : (other % self).gcd(self)
  end

  def lcm(other : Int)
    (self * other).abs / gcd(other)
  end

  def divisible_by?(num)
    self % num == 0
  end

  def even?
    divisible_by? 2
  end

  def odd?
    !even?
  end

  def hash
    self
  end

  def succ
    self + 1
  end

  def times(&block : self -> )
    i = self ^ self
    while i < self
      yield i
      i += 1
    end
    self
  end

  def upto(n, &block : self -> )
    x = self
    while x <= n
      yield x
      x += 1
    end
    self
  end

  def downto(n, &block : self -> )
    x = self
    while x >= n
      yield x
      x -= 1
    end
    self
  end

  def to(n, &block : self -> )
    if self < n
      upto(n) { |i| yield i }
    elsif self > n
      downto(n) { |i| yield i }
    else
      yield self
    end
    self
  end

  def modulo(other)
    self % other
  end

  def to_s(radix : Int)
    if radix < 1 || radix > 36
      raise "Invalid radix #{radix}"
    end

    if self == 0
      return "0"
    end

    str = StringBuffer.new
    num = self

    if num < 0
      str.append_byte '-'.ord.to_u8
      num = num.abs
      init = 1
    else
      init = 0
    end

    while num > 0
      digit = num % radix
      if digit >= 10
        str.append_byte ('a'.ord + digit - 10).to_u8
      else
        str.append_byte ('0'.ord + digit).to_u8
      end
      num /= radix
    end

    # Reverse buffer
    buffer = str.buffer
    init.upto(str.length / 2 + init - 1) do |i|
      buffer.swap(i, str.length - i - 1 + init)
    end

    str.to_s
  end

  def to_modet
    ifdef darwin
      to_u16
    elsif linux
      to_u32
    end
  end

  def to_sizet
    ifdef x86_64
      to_u64
    else
      to_u32
    end
  end

  def to_timet
    ifdef x86_64
      to_i64
    else
      to_i32
    end
  end
end

struct Int8
  MIN = -128_i8
  MAX =  127_i8

  def -
    0_i8 - self
  end

  def to_s
    String.new_with_capacity(5) do |buffer|
      C.sprintf(buffer, "%hhd", self)
    end
  end
end

struct Int16
  MIN = -32768_i16
  MAX =  32767_i16

  def -
    0_i16 - self
  end

  def to_s
    String.new_with_capacity(7) do |buffer|
      C.sprintf(buffer, "%hd", self)
    end
  end
end

struct Int32
  MIN = -2147483648_i32
  MAX =  2147483647_i32

  def -
    0 - self
  end

  def to_s
    String.new_with_capacity(12) do |buffer|
      C.sprintf(buffer, "%d", self)
    end
  end
end

struct Int64
  MIN = -9223372036854775808_i64
  MAX =  9223372036854775807_i64

  def -
    0_i64 - self
  end

  def to_s
    String.new_with_capacity(22) do |buffer|
      C.sprintf(buffer, "%lld", self)
    end
  end
end

struct UInt8
  MIN = 0_u8
  MAX = 255_u8

  def abs
    self
  end

  def to_s
    String.new_with_capacity(5) do |buffer|
      C.sprintf(buffer, "%hhu", self)
    end
  end
end

struct UInt16
  MIN = 0_u16
  MAX = 65535_u16

  def abs
    self
  end

  def to_s
    String.new_with_capacity(7) do |buffer|
      C.sprintf(buffer, "%hu", self)
    end
  end
end

struct UInt32
  MIN = 0_u32
  MAX = 4294967295_u32

  def abs
    self
  end

  def to_s
    String.new_with_capacity(12) do |buffer|
      C.sprintf(buffer, "%u", self)
    end
  end
end

struct UInt64
  MIN = 0_u64
  MAX = 18446744073709551615_u64

  def abs
    self
  end

  def to_s
    String.new_with_capacity(22) do |buffer|
      C.sprintf(buffer, "%lu", self)
    end
  end
end
