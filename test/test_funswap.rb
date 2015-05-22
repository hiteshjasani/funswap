require "minitest/autorun"
require "funswap"

module XYZ
  def self.add2(x)
    x + 2
  end

  module_function
  def mul2(x)
    x * 2
  end
end

module ABC
  module DEF
    def self.add7(x)
      x + 7
    end

    module_function
    def mul5(x)
      x * 5
    end
  end
end

class FunSwapTest < Minitest::Test
  def test_xyz_add2_normal
    assert_equal(4, XYZ.add2(2))
  end

  def test_xyz_add2_swap_add3
    assert_equal(4, XYZ.add2(2))
    FunSwap.with_fn(XYZ, :add2, ->(x) { x + 3 }) do
      assert_equal(5, XYZ.add2(2))
    end
    assert_equal(4, XYZ.add2(2))
  end

  def test_xyz_mul2_normal
    assert_equal(6, XYZ.mul2(3))
  end

  def test_xyz_mul2_swap_mul3
    assert_equal(6, XYZ.mul2(3))
    FunSwap.with_fn(XYZ, :mul2, ->(x) { x * 3 }) do
      assert_equal(9, XYZ.mul2(3))
    end
    assert_equal(6, XYZ.mul2(3))
  end

  def test_abcdef_add7_normal
    assert_equal(9, ABC::DEF.add7(2))
  end

  def test_abcdef_add7_swap_add12
    assert_equal(9, ABC::DEF.add7(2))
    FunSwap.with_fn(ABC::DEF, :add7, ->(x) { x + 12 }) do
      assert_equal(14, ABC::DEF.add7(2))
    end
    assert_equal(9, ABC::DEF.add7(2))
  end

  def test_abcdef_mul5_normal
    assert_equal(15, ABC::DEF.mul5(3))
  end

  def test_abcdef_mul5_swap_mul9
    assert_equal(15, ABC::DEF.mul5(3))
    FunSwap.with_fn(ABC::DEF, :mul5, ->(x) { x * 9 }) do
      assert_equal(27, ABC::DEF.mul5(3))
    end
    assert_equal(15, ABC::DEF.mul5(3))
  end
end

