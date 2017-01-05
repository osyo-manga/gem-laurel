require_relative '../spec_helper'

describe Laurel::Operator do
	class OperatorX
		include Laurel::Operator
	end

	let(:x) { OperatorX.new }
	it { expect(Laurel::Proxy === x & x).to eq true }
	it { expect(Laurel::Proxy === x & x & x).to eq true }

	it { expect(Laurel::Proxy === x | x).to eq true }
	it { expect(Laurel::Proxy === x | x | x).to eq true }

	it { expect(Laurel::Proxy === !x).to eq true }

	it { expect(Laurel::Proxy === !x & x).to eq true }

	it { expect(Laurel::Proxy === !x | x & !x | x).to eq true }
end
