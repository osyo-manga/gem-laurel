require 'spec_helper'


describe Laurel do
	subject(:and_) { -> left, right, name, *args {
		   Laurel.and(left, right).__send__(name, *args)     \
		== (left.__send__(name, *args) && right.__send__(name, *args))
	} }

	subject(:or_) { -> left, right, name, *args {
		   Laurel.or(left, right).__send__(name, *args)     \
		== (left.__send__(name, *args) || right.__send__(name, *args))
	} }

	subject(:not_) { -> obj, _, name, *args {
		   Laurel.not(obj).__send__(name, *args)     \
		== !obj.__send__(name, *args)
	} }

	shared_examples_for "等価" do |*args|
		it { expect(and_.(*args)).to eq true }
		it { expect(or_.(*args) ).to eq true }
		it { expect(not_.(*args)).to eq true }
	end

	it_behaves_like "等価", 1, 2, :==, 1
	it_behaves_like "等価", 1, 2, :==, 2
	it_behaves_like "等価", 2, 2, :==, 2

	it_behaves_like "等価", "",   "",   :empty?
	it_behaves_like "等価", "aa", "",   :empty?
	it_behaves_like "等価", "", "aa",   :empty?
	it_behaves_like "等価", "aa", "aa", :empty?

	it_behaves_like "等価", String, "aaa", :===, 42
	it_behaves_like "等価", String, "aaa", :===, "aaa"
	it_behaves_like "等価", 42, -314, :to_s


	shared_examples_for "不等価" do |*args|
		it { expect(and_.(*args)).to eq false }
		it { expect(or_.(*args) ).to eq false }
	end

	it_behaves_like "不等価", 2, 2, :__id__
	it_behaves_like "不等価", 2, 2, :equal?, 2
end
