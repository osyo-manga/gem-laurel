require_relative '../spec_helper'

using Laurel::Refine


describe Laurel::Refine do
	class RefineX
		def & other
		end

		def | other
		end

		def !
		end
	end

	let(:obj) { Object.new }
	it { expect(Laurel::Proxy === obj & obj).to eq true }
	it { expect(Laurel::Proxy === obj | obj).to eq true }
	it { expect(Laurel::Proxy === !obj).to eq true }
	it { expect(Laurel::Proxy === !42).to eq true }

	let(:x) { RefineX.new }
	it { expect(Laurel::Proxy === 1 & 1).to eq false }
	it { expect(Laurel::Proxy === 1 | 1).to eq false }
	it { expect(Laurel::Proxy === x & x).to eq false }
	it { expect(Laurel::Proxy === x | x).to eq false }
	it { expect(Laurel::Proxy === !x).to eq false }
end
