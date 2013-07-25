class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    puts

    a = A.new; time("Native method (raw)") { a.m }
    b = B.new; time("define_method (raw)") { b.m }
    c = C.new; time("method_missing (raw)") { c.m }
    d = D.new; time("module included in class (raw)") { d.m }
    e = E.new; time("class_addMethod (raw)") { e.m }

    time("Native method (with object creation)") { A.new.m }
    time("define_method (with object creation)") { B.new.m }
    time("method_missing (with object creation)") { C.new.m }
    time("module included in class (with object creation)") { D.new.m }
    time("class_addMethod (with object creation)") { E.new.m }
    time("extend with module on the fly") { f = Object.new; f.extend(Dprime); f.m }
     
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
    puts "%50s: %15f" % [message, times.reduce(:+) / 100]
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
