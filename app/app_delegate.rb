class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    puts

    #puts "%60s: %15f" % ["ObjC native loop", BenchmarkBase.new.]
    r = BenchmarkBase.new;
    time("ObjC native loop", nil, ->(o) { r.benchmark(10000) })
    time("ObjC native loop w/objc_msgSend", nil, ->(o) { r.benchmark_send(10000) })
    time("ObjC method called from ruby (raw)", r)
    a = A.new; time("def method (raw)", a)
    b = B.new; time("define_method (raw)", b)
    c = C.new; time("method_missing (raw)", c)
    d = D.new; time("module included in class (raw)", d)
    e = E.new; time("class_addMethod (raw)", e)

    # time("ObjC method called from ruby (with object creation)") { BenchmarkBase.new.i }
    # time("def method (with object creation)") { A.new.m }
    # time("define_method (with object creation)") { B.new.m }
    # time("method_missing (with object creation)") { C.new.m }
    # time("module included in class (with object creation)") { D.new.m }
    # time("class_addMethod (with object creation)") { E.new.m }
    # time("extend with module on the fly") { f = Object.new; f.extend(Dprime); f.m }

    puts
    puts

    true
  end


  def time(message, object = nil, func = ->(o) { for i in (1..1000).to_a; o.m; end })
    times = 10.times.map {
      t = Time.now
      func.call(object)
      Time.now - t
    }
    puts "%60s: %15f" % [message, times.reduce(:+) / 100]
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
