class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    puts

    a = A.new
    b = B.new
    c = C.new
    d = D.new
    e = E.new

    time("Native method") { a.m }
    time("define_method") { b.m }
    time("method_missing") { c.m }
    time("included module") { d.m }
    time("class_addMethod") { e.m }
     
    puts
    puts
    puts

    true
  end


  def time(message)
    times = 10.times.map {
      t = Time.now
      10000.times { yield }
      Time.now - t
    }
    puts "%30s: %15f" % [message, times.reduce(:+) / 10]
  end

end

class A
  def m
    1
  end

  def n
    2
  end

  def o
    3
  end
end

class B
  define_method(:m) do 
    1
  end

  define_method(:n) do 
    2
  end

  define_method(:o) do 
    2
  end
end

class C
  def method_missing(name, *args)
    if name.to_sym == :m
      1
    elsif name.to_sym == :n
      2
    elsif name.to_sym == :o
      3
    else
      super(name, *args)
    end
  end
end

module Dprime
  def m
    1
  end

  def n
    2
  end

  def o
    3
  end
end

class D
  include Dprime
end

class E < BenchmarkBase

  defineMethod :m, value: 1
  defineMethod :n, value: 2
  defineMethod :o, value: 3

end
