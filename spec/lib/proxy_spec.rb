require_relative '../spec_helper'

describe Laurel::Proxy do
	context "デフォルト引数" do
		subject {
			Laurel.proxy do |name, *args, &block|
				{
					name: name,
					args: args,
					block: block
				}
			end
		}

		context "未定義のメソッドを呼び出した時" do
			let(:block) { proc {} }
			it { expect(subject.homu 1, 2, 3, &block).to include(
				name: :homu,
				args: [1, 2, 3],
				block: block
			) }

			it { expect(subject === 10).to include(name: :===, args: [10]) }
			it { expect(subject).to be_kind_of Laurel::Proxy }
		end

		context "BasicObject で定義されてるメソッドを呼び出した時" do
			it { expect(subject.__id__).to eq subject.__id__ }
			it { expect(subject == subject).to eq true }
			it { expect(subject != subject).to eq false }
			it { expect(subject.equal? subject).to eq true }
		end
	end

	context "method_missing から呼び出すようにする" do
		subject {
			Laurel.proxy [:==, :!=, :!] do |name, *args, &block|
				{
					name: name,
					args: args,
					block: block
				}
			end
		}

		context "BasicObject で定義されてるメソッドを呼び出した時" do
			it { expect(subject.__id__).to eq subject.__id__ }
		end

		context "再定義されてる演算子を呼び出した時" do
			it { expect(subject == 10).to include(name: :==,  args: [10]) }
			it { expect(subject != 10).to include(name: :!=,  args: [10]) }
			it { expect(!subject).to      include(name: :!,   args: []) }
		end
	end
end
