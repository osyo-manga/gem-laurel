require_relative '../spec_helper'

describe Laurel::Proxy do
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
	end

	context "再定義されてる演算子を呼び出した時" do
		it { expect(subject == 10).to include(name: :==,  args: [10]) }
		it { expect(subject != 10).to include(name: :!=,  args: [10]) }
		it { expect(!subject).to      include(name: :!,   args: []) }
	end

	context "BasicObject で定義されてるメソッドを呼び出した時" do
		it { expect(subject.__id__).to eq subject.__id__ }
		it { expect(subject.equal? subject).to eq true }
	end
end