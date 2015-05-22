# funswap

This was born out of my need to do more functional style programming and testing in Ruby.  With normal
object oriented programming, you might use mock objects to handle testing deep stacks.  What do you do
if your stack is functional?  How do you mock pure functions in Ruby?

Let's say you have a module with some functions.

```ruby
module ABC
  def self.add2(x)
    x + 2
  end

  module_function
  def mul5(x)
    x * 5
  end
end
```

It's easy enough to test these in a straightforward manner since they are functions with no dependency on
any shared data.  Now suppose those are used in another set of functions or even object#methods.

```ruby
module XYZ
  def self.calculate_sales_tax(a, b, ...)
  # ... some work
  z = ABC.add2(b)
  # ... some work
  end
end

class TUVController
  def index
    # ... some stuff
    z = ABC.mul5(n)
    # ... some stuff
  end
end
```

How would you mock out the calls to `ABC.add2()` and `ABC.mul5()` while testing the XYZ module or the TUVController?
Perhaps you want `ABC.add2()` to return a different value or throw an exception.  That's what mock object libraries
enable for objects and FunSwap makes possible with functions.

```ruby
# outputs 5
puts ABC.add2(3)

# outputs 24
FunSwap.with_fn(ABC, :add2, ->(x) { x + 21 }) do
  puts ABC.add2(3)
end

# outputs 5 again - the swapping of add2() did not leak outsite the block
puts ABC.add2(3)
```

The mocking is only done for the duration of the block.  Outside of it, the original behavior of the function
is maintained.


