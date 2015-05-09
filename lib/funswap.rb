
module FunSwap
  # Swap module function in method and return the old function.
  #
  # mod:module -> fn_name:symbol -> fn:proc -> old_fn:proc
  #
  def self.swap(mod, fn_name, fn)
    old_fn = mod.method(fn_name).to_proc
    begin
      eigenclass = class << mod; self; end
      eigenclass.class_eval { remove_method fn_name }
    rescue NameError
    end
    mod.class.send(:define_method, fn_name, fn)
    old_fn
  end

  def self.with_fn(mod, fn_name, fn, &blk)
    old_fn = swap(mod, fn_name, fn)
    blk.call()
  ensure
    swap(mod, fn_name, old_fn)
  end
end

