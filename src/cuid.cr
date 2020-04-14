require "big"

struct CUID
  VERSION = "0.1.0"

  @bytes : StaticArray(UInt8, 25)

  @@count : UInt64 = 0

  # Generates a `CUID` from *bytes*
  def initialize(@bytes : StaticArray(UInt8, 25))
  end

  # Generates a random `CUID`
  def self.random
    counter = pad(safe_counter.to_s(BASE), BLOCK_SIZE)

    hashed_cuid = "c" + timestamp + counter + fingerprint + randomized
    new(hashed_cuid.to_slice)
  end

  # Generates a CUID from 16-bytes slice.
  def self.new(slice : Slice(UInt8))
    bytes = uninitialized UInt8[25]
    slice.copy_to(bytes.to_slice)

    new(bytes)
  end

  # Converts a `String` into a `CUID`.
  def self.new(string : String)
    new(string.to_slice)
  end

  # Convert to `String` in a literal format.
  def inspect(io : IO) : Nil
    io << "CUID("
    to_s(io)
    io << ')'
  end

  def to_s(io : IO) : Nil
    io.write(@bytes.to_slice)
  end

  BLOCK_SIZE = 4_u64

  BASE = 36_u64

  DISCRETE_VALUES = BASE ** BLOCK_SIZE

  RAND_SIZE = BLOCK_SIZE * 2

  RAND_MAX = (BASE ** RAND_SIZE) - 1

  RAND_MIN = BASE ** (RAND_SIZE - 1)

  # Creates a timestamp in base 36
  private def self.timestamp
    Time.local.to_unix_ms.to_s(36)
  end

  # Returns a counter
  private def self.safe_counter
    @@count = @@count < DISCRETE_VALUES ? @@count : 0_u64
    @@count += 1_u64

    @@count - 1_u64
  end

  # Returns a fingerprint based on the process pid and the hostname
  private def self.fingerprint
    pid = Process.pid.to_s(BASE)
    hostname = System.hostname
    hostid = hostname.split("").reduce(hostname.size + BASE) { |acc, i| acc + i[0].ord }
    pad(pid, 2) + pad(hostid.to_s(36), 2)
  end

  # Returns a cryptographically secure random number in base 36
  private def self.randomized
    value = Random::Secure.rand(RAND_MAX - RAND_MIN) + RAND_MIN
    value.to_big_i.to_s(BASE)
  end

  # Adds a padding '0' to the left to complete the length
  private def self.pad(text, length)
    text = text.rjust(length, '0')
    index = text.size - length
    text[index..]
  end
end
